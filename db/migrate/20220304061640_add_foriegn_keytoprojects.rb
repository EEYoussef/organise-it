class AddForiegnKeytoprojects < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :projects, :users , column: :freelancer_user_id
  end

end
