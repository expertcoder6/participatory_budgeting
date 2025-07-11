ActiveAdmin.register VotingPhase do
  menu label: 'Voting Phases', priority: 6

  permit_params :name, :start_date, :end_date, :voting_rule, :status

  index do
    selectable_column
    id_column
    column :name
    column :start_date
    column :end_date
    column :voting_rule, as: :select, collection: ["single_vote", "multi_vote"]
    column :status, as: :select, collection: ["upcoming", "active", "ended"]
    column("Total Votes") { |phase| phase.votes.count }
    column("Total Amount Allocated") { |phase| number_to_currency(phase.votes.sum(:amount)) }
    actions
  end

  show do
    attributes_table do
      row :name
      row :start_date, as: :datepicker
      row :end_date, as: :datepicker
      row :voting_rule
      row :status
      row("Total Votes") { voting_phase.votes.count }
      row("Total Amount Allocated") { number_to_currency(voting_phase.votes.sum(:amount)) }
    end

    panel "Top Voted Proposals" do
      top_votes = voting_phase.votes
        .group(:budget_proposal_id)
        .sum(:amount)
        .sort_by { |_, sum| -sum }
        .first(5)

      table_for top_votes do
        column("Proposal") do |proposal_id, _|
          proposal = BudgetProposal.find_by(id: proposal_id)
          proposal ? link_to(proposal.title, admin_budget_proposal_path(proposal)) : "Deleted Proposal"
        end
        column("Amount") { |_, amount| number_to_currency(amount) }
      end
    end

    panel "Category-wise Spending" do
      spending_data = voting_phase.votes
        .joins(budget_proposal: :budget_category)
        .group("budget_categories.name")
        .sum(:amount)

      table_for(spending_data.to_a) do
        column("Category") { |(category_name, _)| category_name }
        column("Amount Spent") { |(_, amount)| number_to_currency(amount) }
      end
    end

  end
end
