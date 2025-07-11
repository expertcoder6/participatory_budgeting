class BudgetCategoriesController < ApplicationController
  before_action :authenticate_user!
	
  def index
    @categories = BudgetCategory.includes(:budget_proposals)
  end

  def show
    @budget_category = BudgetCategory.find(params[:id])
  end
end
