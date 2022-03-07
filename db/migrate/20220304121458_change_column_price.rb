class ChangeColumnPrice < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :price, :int ,:null => false
  end
end
