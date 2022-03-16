class CreateProjectOutcomes < ActiveRecord::Migration[6.1]
  def change
    create_table :project_outcomes do |t|
      t.string :title
      t.text :details
      t.time :timestamp
      t.boolean :done
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
