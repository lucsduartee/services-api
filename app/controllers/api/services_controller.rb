class Api::ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  def create
    service = Services.create(create_params)

    render json: { service: service }, status: :created
  end

  def update
    service = Services.update(update_params)

    render json: { service: service }, status: :ok
  end

  private

  def create_params
    params.permit(:name, :description, :cost)
  end

  def update_params
    params.permit(:gross_margin, :status)
  end
end
