class Services
  class << self
    def getAll
      Service.all
    end

    def get(id)
      Service.find(id)
    end

    def create(params)
      Service.create!(
        name: params[:name],
        description: params[:description],
        cost: params[:cost],
      )
    end

    def update(params)
      Service.update!(
        gross_margin: params[:gross_margin],
        status: params[:status],
      )
    end
  end
end
