class VotesController < ApplicationController
  before_action :authenticate_user!

  def new
    @budget_proposal = BudgetProposal.find(params[:budget_proposal_id])
    @voting_phase = VotingPhase.find_by("start_date <= ? AND end_date >= ?", Time.current, Time.current)

    unless @voting_phase
      flash[:alert] = "No active voting phase."
      return redirect_to budget_categories_path
    end

    @vote = Vote.new
  end

  def create
    @budget_proposal = BudgetProposal.find(vote_params[:budget_proposal_id])
    @category = @budget_proposal.budget_category
    @phase = VotingPhase.find(vote_params[:voting_phase_id])
    @vote_amount = vote_params[:amount].to_d

    unless @phase
      flash[:alert] = "No active voting phase."
      return redirect_to budget_categories_path
    end

    if @phase.voting_rule == "single_vote"
      existing_phase_vote = Vote.find_by(user_id: current_user.id, voting_phase_id: @phase.id)
      if existing_phase_vote && existing_phase_vote.budget_proposal_id != @budget_proposal.id
        flash[:alert] = "You can only vote for one proposal in this phase."
        return redirect_to budget_categories_path
      end
    end

    existing_vote = Vote.find_by(
      user_id: current_user.id,
      budget_proposal_id: @budget_proposal.id,
      voting_phase_id: @phase.id
    )

    adjusted_remaining_budget = @category.remaining_budget_for_category
    adjusted_remaining_budget += existing_vote.amount if existing_vote

    if adjusted_remaining_budget >= @vote_amount
      begin
        if existing_vote
          existing_vote.update!(amount: @vote_amount)
          flash[:notice] = "Vote updated successfully."
        else
          current_user.votes.create!(
            budget_proposal: @budget_proposal,
            voting_phase: @phase,
            amount: @vote_amount
          )
          flash[:notice] = "Vote cast successfully."
        end
      rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = e.message
      end
    else
      flash[:alert] = "Category spending limit exceeded."
    end

    redirect_to budget_categories_path
  end

  private

  def vote_params
    params.require(:vote).permit(:budget_proposal_id, :voting_phase_id, :amount)
  end
end
