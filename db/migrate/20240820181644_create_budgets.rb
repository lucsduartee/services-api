class CreateBudgets < ActiveRecord::Migration[7.2]
  def change
    create_table :budgets do |t|
      t.belongs_to :service, foreign_key: true
      t.string :name
      t.string :budget_url
      t.decimal :value

      t.timestamps
    end
  end
end
