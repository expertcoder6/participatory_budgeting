class CreateBudgetProposals < ActiveRecord::Migration[7.2]
  def change
    create_table :budget_proposals do |t|
      t.string :title
      t.float :amount
      t.references :user, null: false, foreign_key: true
      t.references :budget_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
