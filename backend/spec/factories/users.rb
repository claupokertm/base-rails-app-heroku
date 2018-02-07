FactoryBot.define do
  factory :user do
    name 'User Full Name'

    sequence :username do |n|
      "user_#{n}"
    end

    sequence :email do |n|
      "email_#{n}@example.com"
    end
    password 'password_password'
    verified true
    role 0
    avatar_url 'avatar'
  end
end
