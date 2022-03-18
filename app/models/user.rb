class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
  has_many:user_skills
  has_many:projects
  has_many:freelancer_user_project, class_name: 'Project', foreign_key: 'freelancer_user_id'
  has_many:offers
  has_one_attached:picture
  has_many :recieve_payments, foreign_key: "freelanceruser_id", class_name: "Payment"
  has_many :make_payments, foreign_key: "user_id", class_name: "Payment"
  
end
