class Api::ExpensesController < ApplicationController
  def create
    @expense = Expense.new(expense_params)

    render json: { eeee: "eeee" }, status: created
  end

  def update
    @expense = Expense.find(params[:id])

    render json: { eeee: "eeee" }, status: created
  end

  private

  def expense_params
    params.permit(:up_payments_count_with, :description, :name, :type, :value)
  end
end
