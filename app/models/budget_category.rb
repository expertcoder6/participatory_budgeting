class BudgetCategory < ApplicationRecord
  has_many :budget_proposals
  belongs_to :budget

  def total_votes_allocated
    budget_proposals.joins(:votes).sum(:amount)
  end

  def total_budget_limit_amount
    return 0 unless budget&.total_amount.present?
    budget.total_amount * (spending_limit_percentage.to_f / 100)
  end

  def remaining_budget_for_category
	  total_votes = budget_proposals.joins(:votes).sum(:amount)
	  max_allowed = (spending_limit_percentage.to_f / 100.0) * Budget.total_amount
	  max_allowed - total_votes
	end

  def utilization_percentage
    return 0 if total_budget_limit_amount.zero?
    ((total_votes_allocated / total_budget_limit_amount) * 100).round(2)
  end

  def self.ransackable_associations(_auth_object = nil)
    ["budget_proposals"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "name", "spending_limit_percentage", "budget_id","created_at", "updated_at"]
  end
end


