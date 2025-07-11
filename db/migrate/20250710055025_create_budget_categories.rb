class CreateBudgetCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :budget_categories do |t|
      t.string :name
      t.decimal :spending_limit_percentage, precision: 5, scale: 2
      t.references :budget, null: false, foreign_key: true
      t.timestamps
    end
  end
end
