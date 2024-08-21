class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :cost, :gross_margin, :status, :spent_value

  def spent_value
    self.object.expense.pluck(:value).sum
  end
end
