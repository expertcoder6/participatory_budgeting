class CreateVotingPhases < ActiveRecord::Migration[7.2]
  def change
    create_table :voting_phases do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.string :voting_rule

      t.timestamps
    end
  end
end
