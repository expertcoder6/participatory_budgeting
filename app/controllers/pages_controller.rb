class PagesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if user_signed_in?
      redirect_to budget_categories_path
    else
      redirect_to new_user_registration_path
    end
  end
end

