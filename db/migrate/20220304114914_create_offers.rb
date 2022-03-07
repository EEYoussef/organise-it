class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.text :message
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.boolean :accept , default: false

      t.timestamps
    end
  end
end
