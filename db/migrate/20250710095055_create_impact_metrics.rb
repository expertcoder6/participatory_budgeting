class CreateImpactMetrics < ActiveRecord::Migration[7.2]
  def change
    create_table :impact_metrics do |t|
      t.integer :estimated_beneficiaries
      t.string :timeline
      t.integer :sustainability_score
      t.references :budget_proposal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
