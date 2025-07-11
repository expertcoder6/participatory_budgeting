class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :budget_proposal
  belongs_to :voting_phase

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :within_category_limit
  validates :user_id, uniqueness: { scope: [:budget_proposal_id, :voting_phase_id], message: "has already voted for this proposal in this phase" }

  def within_category_limit
    category = budget_proposal.budget_category
    if category.present? && (category.total_votes_allocated + amount.to_d) > category.total_budget_limit_amount
      errors.add(:amount, "exceeds the remaining budget limit for the '#{category.name}' category.")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "budget_proposal_id", "voting_phase_id", "amount", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "budget_proposal", "voting_phase"]
  end
end
