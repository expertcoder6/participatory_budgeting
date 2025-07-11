class BudgetProposal < ApplicationRecord
  belongs_to :user
  belongs_to :budget_category
  has_many :votes
  has_one :impact_metric, dependent: :destroy
  accepts_nested_attributes_for :impact_metric


  def total_votes
    votes.sum(:amount)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "budget_category_id", "created_at", "id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "budget_category", "votes","impact_metric"]
  end
end

