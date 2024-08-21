class Expense < ApplicationRecord
  belongs_to :service

  validates :name, :value, :type, :total_payments, presence: true
  validates :value, numericality: { greater_than: true }
  validates :total_payments, numericality: true
end
