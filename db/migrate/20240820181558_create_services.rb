class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :cost
      t.decimal :gross_margin
      t.string :status

      t.timestamps
    end
  end
end
