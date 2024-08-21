class Api::BudgetsController < ApplicationController
  def create
    @budget = Budget.new(budget_params)

    render json: { bbbb: "bbbb" }, status: created
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :value)
  end
end
