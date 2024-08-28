class Expense < ApplicationRecord
  belongs_to :service

  validates :name, :value, :category, :total_payments, presence: true
  validates :value, numericality: { greater_than: 0 }
  validates :total_payments, numericality: true
end
