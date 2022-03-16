class Project < ApplicationRecord
  belongs_to :user
  has_many_attached:pictures
  belongs_to :freelancer_user, class_name: 'User', optional: true
  has_many :offers
  has_many :project_outcomes
  validates :price, numericality: { only_integer: true ,greater_than:0,less_than:10000, messsage: "%{value} is not a valid size"  }
  validates :title, presence: true
  
end
