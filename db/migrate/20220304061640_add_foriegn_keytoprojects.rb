class AddForiegnKeytoprojects < ActiveRecord::Migration[6.1]
  
  def change
    add_column :projects, :freelanceruser_id, :int
    add_foreign_key :projects, :users , column: :freelanceruser_id
  end

end
