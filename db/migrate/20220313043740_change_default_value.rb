class ChangeDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :project_outcomes, :done, :boolean, :default => false
  end
end
