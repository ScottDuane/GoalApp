FactoryGirl.define do
  factory :goal do
    user_id 1
    description { Faker::Hacker.say_something_smart }
  end

end
