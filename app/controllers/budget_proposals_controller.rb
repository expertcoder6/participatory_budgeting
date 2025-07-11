class BudgetProposalsController < ApplicationController
  before_action :authenticate_user!

   def index
    @budget_proposals = BudgetProposal.includes(:impact_metric).joins(:impact_metric)

    if params[:min_beneficiaries].present?
      @budget_proposals = @budget_proposals.where("impact_metrics.estimated_beneficiaries >= ?", params[:min_beneficiaries])
    end

    if params[:min_sustainability_score].present?
      @budget_proposals = @budget_proposals.where("impact_metrics.sustainability_score >= ?", params[:min_sustainability_score])
    end
  end

  def new
    @budget_proposal = BudgetProposal.new
    @budget_proposal.build_impact_metric
  end

  def create
    @budget_proposal = current_user.budget_proposals.new(budget_proposal_params)
    if @budget_proposal.save
      redirect_to budget_categories_path, notice: "Proposal submitted"
    else
      render :new
    end
  end

  private

  def budget_proposal_params
    params.require(:budget_proposal).permit(:title, :amount, :budget_category_id,
      impact_metric_attributes: [:estimated_beneficiaries, :timeline, :sustainability_score])
  end

end

