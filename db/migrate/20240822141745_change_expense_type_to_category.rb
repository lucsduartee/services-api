class ChangeExpenseTypeToCategory < ActiveRecord::Migration[7.2]
  def change
    rename_column :expenses, :type, :category
  end
end
