FactoryGirl.define do
  factory :goal_comment do
    body { Faker::Hacker.say_something_smart }
    goal_id 1
    author_id 1
    recipient_id 2
  end

end
