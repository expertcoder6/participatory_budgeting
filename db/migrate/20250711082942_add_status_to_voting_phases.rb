class AddStatusToVotingPhases < ActiveRecord::Migration[7.2]
  def change
    add_column :voting_phases, :status, :string
  end
end
