class User < ApplicationRecord
  before_destroy :ensure_admin
  before_update :ensure_admin

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  
  def ensure_admin
    self.admin = true if User.where(admin: true).count <= 1
  end
end
