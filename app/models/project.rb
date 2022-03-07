class Project < ApplicationRecord
  belongs_to :user
  has_one_attached:picture
  belongs_to :freelancer_user, class_name: 'User', optional: true
  has_many :offers
end
