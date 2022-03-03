class RenameColumnInProject < ActiveRecord::Migration[6.1]
  def change
    rename_column :projects, :name, :title
   
  end
end
