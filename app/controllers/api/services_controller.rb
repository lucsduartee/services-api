class Api::ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    services = Services.getAll

    render json: services, each_serializer: ServiceSerializer, status: :ok
  rescue => e
    render json: { message: e.message }, status: :internal_server_error
  end

  def show
    service = Services.get(params[:id])

    render json: { service: service }, status: :ok
  rescue => e
    render json: { message: e.message }, status: :internal_server_error
  end

  def create
    service = Services.create(create_params)

    render json: { service: service }, status: :created
  rescue => e
    render json: { message: e.message }, status: :unprocessable_entity
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
    params.permit(:gross_margin, :service_status, :id)
  end
end
