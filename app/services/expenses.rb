class Expenses
  class << self
    def get_expenses_by_service_id(id)
      Services.get_expenses(id)
    end

    def create(params, file)
      Expense.create!(
        name: params[:name],
        value: params[:value],
        total_payments: params[:total_payments],
        category: params[:category],
        service_id: params[:service_id],
        nota_fiscal: file,
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

    def get_nota_fiscal(id)
      Expense.find(id)&.nota_fiscal&.url
    end

    private

    def upload_to_s3(filename, filepath)
      bucket_manager = AwsBucketManager.new
      bucket_manager.upload_file(filename, filepath)
    end
  end
end
