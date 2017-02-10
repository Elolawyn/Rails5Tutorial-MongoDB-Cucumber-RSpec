class Micropost
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :content, type: String

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
