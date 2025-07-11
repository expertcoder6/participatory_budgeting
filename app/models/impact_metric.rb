class ImpactMetric < ApplicationRecord
  belongs_to :budget_proposal
  validates :estimated_beneficiaries, :timeline, :sustainability_score, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "timeline",
      "estimated_beneficiaries",
      "implementation_timeline_months",
      "sustainability_score",
      "budget_proposal_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["budget_proposal"]
  end
end

