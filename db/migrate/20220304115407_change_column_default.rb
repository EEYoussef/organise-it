class ChangeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :offers, :accept, :boolean, :default => false
  end
end
