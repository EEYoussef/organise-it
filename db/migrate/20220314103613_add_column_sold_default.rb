class AddColumnSoldDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :sold, :boolean, default: false
  end
end
