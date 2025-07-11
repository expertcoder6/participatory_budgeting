ActiveAdmin.register BudgetProposal do
  menu label: 'BudgetProposal', priority: 4

  includes :impact_metric

  permit_params :title, :amount, :budget_category_id, :user_id,
    impact_metric_attributes: [:estimated_beneficiaries, :timeline, :sustainability_score]

  form do |f|
    f.inputs "Proposal Details" do
      f.input :title
      f.input :amount
      f.input :budget_category
      f.input :user
    end

    f.inputs "Impact Metrics", for: [:impact_metric, f.object.impact_metric || ImpactMetric.new] do |impact_f|
      impact_f.input :estimated_beneficiaries
      impact_f.input :timeline
      impact_f.input :sustainability_score
    end

    f.actions
  end

  show do
    attributes_table do
      row :title
      row :amount
      row("Estimated Beneficiaries") { |bp| bp.impact_metric&.estimated_beneficiaries }
      row("Timeline") { |bp| bp.impact_metric&.timeline }
      row("Sustainability Score") { |bp| bp.impact_metric&.sustainability_score }
    end
  end
end
