class Project < ApplicationRecord
  belongs_to :user
  has_many_attached:pictures
  belongs_to :freelancer_user, class_name: 'User', optional: true
  has_many :offers
  has_many :project_outcomes
  validates :price, numericality: { only_integer: true ,greater_than:0,less_than:10000, messsage: "%{value} is not a valid size"  }
  validates :title, presence: true, length: {minimum: 4}
  
  

  # sanitise data with lifecycle hooks 
  before_save :remove_whitespace
  
  before_validation :convert_price_to_cents, if: :price_changed?

  private 
  
  def remove_whitespace 
    self.title = self.title.strip
    self.description = self.description.strip
  end
  def convert_price_to_cents 
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end 

end
