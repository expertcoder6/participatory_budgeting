ActiveAdmin.register Vote do
  menu label: 'Vote', priority: 7

  permit_params :user_id, :budget_proposal_id, :voting_phase_id, :amount

  index do
    selectable_column
    id_column
    column :user
    column :budget_proposal
    column :voting_phase
    column :amount
    column :created_at
    actions
  end

  filter :user
  filter :budget_proposal
  filter :voting_phase
  filter :amount
  filter :created_at

  show do
    attributes_table do
      row :id
      row :user
      row :budget_proposal
      row :voting_phase
      row :amount
      row :created_at
      row :updated_at
    end
  end
end
