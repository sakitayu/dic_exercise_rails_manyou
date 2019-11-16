class Task < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 20 }
  validates :detail,
    presence: true,
    length: { maximum: 80 }
  default_scope -> { order(created_at: :desc) }
end
