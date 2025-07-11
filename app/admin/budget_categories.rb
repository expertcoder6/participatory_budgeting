ActiveAdmin.register BudgetCategory do
  menu label: 'BudgetCategory', priority: 3

  permit_params :name, :spending_limit_percentage, :budget_id

  index do
    selectable_column
    id_column
    column :name
    column :spending_limit_percentage
    column :budget
    column("Utilization %") { |cat| cat.utilization_percentage }
    actions
  end

  form do |f|
    f.inputs do
      f.input :budget
      f.input :name
      f.input :spending_limit_percentage
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :budget
      row :spending_limit_percentage
      row("Utilization (%)") { |cat| cat.utilization_percentage }
    end
    active_admin_comments
  end
end
