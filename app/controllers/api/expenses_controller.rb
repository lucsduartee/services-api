class Api::ExpensesController < ApplicationController
  def index
    expenses = Expenses.get_expenses_by_service_id(params[:service_id])

    render json: { expenses: expenses }, status: :ok
  rescue => e
    render json: { message: e.message }, status: :internal_server_error
  end

  def create
    expense = Expenses.create(create_params, create_params[:file])

    render json: { expense: expense }, status: :created
  rescue => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def update
    @expense = Expense.find(params[:id])

    render json: { eeee: "eeee" }, status: :ok
  end

  def download_nota_fiscal
    download_link = Expenses.get_nota_fiscal(params[:id])

    render json: download_link, status: :ok
  rescue => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private

  def create_params
    params.permit(:total_payments, :file, :name, :category, :value, :service_id)
  end

  def update_params
    params.permit(:increase_payments_count_in)
  end
end
