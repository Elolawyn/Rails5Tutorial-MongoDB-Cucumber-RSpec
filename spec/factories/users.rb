FactoryGirl.define do
  factory :michael, :class => :user do
    name "Michael Example"
    email "michael@example.com"
  	password_digest User.digest('password')
    admin true
    activated true
    activated_at Time.zone.now
  end

  factory :archer, :class => :user do
    name "Sterling Archer"
    email "duchess@example.gov"
  	password_digest User.digest('password')
    activated true
    activated_at Time.zone.now
  end

  factory :example_user, :class => :user do
    name "Example User"
    email "user@example.com"
  	password 'foobar'
  	password_confirmation 'foobar'
  end
end