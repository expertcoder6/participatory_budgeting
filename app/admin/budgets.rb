ActiveAdmin.register Budget do
  menu label: 'Budget', priority: 2

  permit_params :name, :total_amount

  filter :name
  filter :total_amount
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column("Total Budget") { |b| number_to_currency(b.total_amount) }
    column("Created") { |b| b.created_at.strftime("%d-%b-%Y") }
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :total_amount, hint: "Total available budget in ₹"
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row("Total Budget") { |b| number_to_currency(b.total_amount) }
      row :created_at
      row :updated_at
    end

    panel "Associated Categories" do
      table_for budget.budget_categories do
        column :name
        column("Limit %", &:spending_limit_percentage)
        column("Limit (₹)") { |cat| number_to_currency(cat.total_budget_limit_amount) }
        column("Used (₹)") { |cat| number_to_currency(cat.total_votes_allocated) }
        column("Remaining (₹)") { |cat| number_to_currency(cat.remaining_budget_for_category) }
        column("Utilization (%)", &:utilization_percentage)
      end
    end

    active_admin_comments
  end
end
