class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :budget
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.references :freelancer_user, null: true, foreign_key: true
      

      t.timestamps
    end
  end
end
