class Budget < ApplicationRecord
  belongs_to :service

  validates :name, :budget_url, :value, presence: true
  validates :value, numericality: { greater_than: 0 }
end
