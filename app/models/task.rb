class Task < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 20 }
  validates :detail,
    presence: true,
    length: { maximum: 80 }
  #default_scope -> { order(created_at: :desc) }
  #scope :sort_expired, -> { order(expired_at: :desc) }
  scope :name_search, -> { where("name LIKE ?", "%#{ params[:name] }%") }
  scope :status_search, -> { where("status LIKE ?", "%#{ params[:status] }%") }
  scope :name_and_status_search, -> { where("status LIKE ?", "%#{ params[:status] }%").where("name LIKE ?", "%#{ params[:name] }%") }
end
