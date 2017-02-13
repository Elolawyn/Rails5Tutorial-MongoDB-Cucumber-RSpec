class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  embeds_many :microposts

  before_save   :downcase_email
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :remember_digest, type: String
  field :admin, type: Boolean, default: false
  field :activation_digest, type: String
  field :activated, type: Boolean, default: false
  field :activated_at, type: DateTime
  field :reset_digest, type: String
  field :reset_sent_at, type: DateTime
  has_and_belongs_to_many :following, class_name: 'User', inverse_of: :followers
  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following

  attr_accessor :remember_token, :activation_token, :reset_token
  
  has_secure_password

  index({ email: 1 }, { unique: true })

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  #def feed
    #self.microposts.all
  #end

  def feed
    posts = self.microposts
    self.following.each do |user_siguiendo|
      posts = posts + user_siguiendo.microposts
    end
    if posts.count >= 2 then posts = posts.sort { |x, y| y.created_at <=> x.created_at } end
    return posts
  end

  # Follows a user.
  def follow(other_user)
    self.following << other_user
    other_user.followers << self
    self.save
    other_user.save
  end

  # Unfollows a user.
  def unfollow(other_user)
    self.following.delete(other_user)
    other_user.followers.delete(self)
    self.save
    other_user.save
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    self.following.include?(other_user)
  end

  # Returns true if the current user is beign followed by the other user.
  def followed?(other_user)
    self.followers.include?(other_user)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end