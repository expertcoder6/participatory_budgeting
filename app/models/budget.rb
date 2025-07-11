class Budget < ApplicationRecord
  def self.total_amount
    500000
  end
  has_many :budget_categories, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "total_amount", "created_at", "updated_at"]
  end
end
