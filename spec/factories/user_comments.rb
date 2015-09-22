FactoryGirl.define do
  factory :user_comment do
    body { Faker::Hacker.say_something_smart }
    author_id 1
    recipient_id 2
  end

end
