class VotingPhase < ApplicationRecord
  has_many :votes

  def active?
    start_date <= Time.current && end_date >= Time.current
  end

  scope :active,   -> { where(status: "active") }
  scope :upcoming, -> { where(status: "upcoming") }
  scope :ended,    -> { where(status: "ended") }

  def self.update_phase_statuses!
    now = Time.current

    all.find_each do |phase|
      new_status =
        if phase.start_date <= now && now <= phase.end_date
          "active"
        elsif now < phase.start_date
          "upcoming"
        else
          "ended"
        end

      phase.update!(status: new_status) if phase.status != new_status
    end
  end

  def self.ransackable_associations(_auth_object = nil)
    ["votes"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "name", "start_date", "end_date", "voting_rule", "status", "created_at", "updated_at"]
  end
end
