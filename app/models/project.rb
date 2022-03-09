class Project < ApplicationRecord
  belongs_to :user
  has_many_attached:pictures
  belongs_to :freelancer_user, class_name: 'User', optional: true
  has_many :offers
  
end
