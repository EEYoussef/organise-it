class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :message, presence: true,length: {minimum: 4}
   # sanitise data with lifecycle hooks 
   before_save :remove_whitespace
  
  
 
   private 
   
   def remove_whitespace 
     
     self.message = self.message.strip
   end
   
 
end
