class CreateBudgets < ActiveRecord::Migration[7.2]
  def change
    create_table :budgets do |t|
      t.string :name
      t.decimal :total_amount
      t.timestamps
    end
  end
end
