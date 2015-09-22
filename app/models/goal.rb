class Goal < ActiveRecord::Base
  validates :user_id, :description, presence: true
  belongs_to :user
end
