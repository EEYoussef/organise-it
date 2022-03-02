class CreateUserSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :user_skills do |t|
      t.references :user, null: true, foreign_key: true
      t.references :skill, null: true, foreign_key: true

      t.timestamps
    end
  end
end
