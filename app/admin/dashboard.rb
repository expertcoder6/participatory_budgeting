ActiveAdmin.register_page "Dashboard" do
  menu label: 'Dashboard', priority: 1
  content do
    panel "Budget Category Overview" do
      table_for BudgetCategory.all do
        column :name
        column :spending_limit_percentage
        column("Used") { |c| number_to_currency(c.total_votes_allocated) }
        column("Limit Amount") { |c| number_to_currency(c.total_budget_limit_amount) }
        column("Utilization %") { |c| "#{c.utilization_percentage}%" }
      end
    end
  end
end
