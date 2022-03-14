class AddColumnSold < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :sold, :boolean, deafult: false
  end
end
