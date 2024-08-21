class Service < ApplicationRecord
  has_many :budget
  has_many :expense

  validates :name, :cost, :description, presence: true
end
