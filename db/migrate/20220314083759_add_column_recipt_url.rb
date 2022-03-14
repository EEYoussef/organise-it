class AddColumnReciptUrl < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :receipt_url, :text
  end
end
