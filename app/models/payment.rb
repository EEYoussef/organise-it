class Payment < ApplicationRecord
  belongs_to :project
  belongs_to :freelanceruser , foreign_key: "freelanceruser_id", class_name: "User"
  belongs_to :user, foreign_key: "user_id", class_name: "User"
end
