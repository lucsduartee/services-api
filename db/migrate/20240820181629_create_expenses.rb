class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.belongs_to :service, foreign_key: true
      t.string :name
      t.decimal :value
      t.string :type
      t.integer :total_payments
      t.integer :payments
      t.string :nota_fiscal_url

      t.timestamps
    end
  end
end
