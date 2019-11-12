class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  default_scope -> { order(created_at: :desc) }
end
