class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one  :site_role, dependent: :destroy

  has_many :domains, dependent: :destroy
  has_many :snap_shots, through: :domains
  has_many :comments, dependent: :destroy

  delegate :role, to: :site_role, allow_nil: true

  def admin?
    site_role&.admin?
  end

  def client?
    site_role&.client?
  end
end
