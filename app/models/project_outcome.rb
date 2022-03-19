class ProjectOutcome < ApplicationRecord
  belongs_to :project
  validates :details, presence: true
  validates :title, presence: true,length: {minimum: 4}
   # sanitise data with lifecycle hooks 
   before_save :remove_whitespace
  
 
   private 
   
   def remove_whitespace 
     self.title = self.title.strip
     self.details = self.details.strip
   end
   
end
