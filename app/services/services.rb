class Services
  class << self
    def getAll
      Service.all
    end

    def get(id)
      Service.find(id)
    end

    def get_expenses(id)
      get(id).expense
    end

    def create(params)
      Service.create!(
        name: params[:name],
        description: params[:description],
        cost: params[:cost],
      )
    end

    def update(params)
      service = Service.find(params[:id])

      service.update!(
        gross_margin: params[:gross_margin],
        status: params[:service_status],
      )

      service.reload
      service
    end
  end
end
