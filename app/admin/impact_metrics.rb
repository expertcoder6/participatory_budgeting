ActiveAdmin.register ImpactMetric do
  menu label: 'ImpactMetric', priority: 5

  permit_params :budget_proposal_id, :estimated_beneficiaries, :timeline, :sustainability_score

  index do
    column :budget_proposal
    column :estimated_beneficiaries
    column :timeline
    column :sustainability_score
    actions
  end

  form do |f|
    f.inputs do
      f.input :budget_proposal
      f.input :estimated_beneficiaries
      f.input :timeline
      f.input :sustainability_score
    end
    f.actions
  end
end
