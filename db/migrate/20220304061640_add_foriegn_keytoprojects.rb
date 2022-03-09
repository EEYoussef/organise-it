class AddForiegnKeytoprojects < ActiveRecord::Migration[6.1]
  
  def change
    add_reference :projects, :freelanceruser_id, index: true
    add_foreign_key :projects, :users , column: :freelanceruser_id
  end

end
