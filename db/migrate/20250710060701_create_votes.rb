class CreateVotes < ActiveRecord::Migration[7.2]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :budget_proposal, null: false, foreign_key: true
      t.references :voting_phase, null: false, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false  # <-- add this
      t.timestamps
    end
  end
end
