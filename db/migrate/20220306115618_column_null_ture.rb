class ColumnNullTure < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :freelanceruser_id, :int, null: true
  end
end
