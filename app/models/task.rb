class Task < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 20 }
  validates :detail,
    presence: true,
    length: { maximum: 80 }
  scope :name_search, -> (params_name) { where("name LIKE ?", "%#{params_name}%") }
  scope :status_search, -> (params_status) { where("status LIKE ?", "%#{params_status}%") }
  scope :name_and_status_search, -> (params_name, params_status) { where("status LIKE ?", "%#{params_status}%").where("name LIKE ?", "%#{params_name}%") }
  enum priority:{高:1,中:2,低:3}
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
