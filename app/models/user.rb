class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization

  has_one :site_role, dependent: :destroy

  has_many :domains, dependent: :destroy
  has_many :snap_shots, through: :domains
  has_many :comments, dependent: :destroy

  delegate :role, to: :site_role, allow_nil: true

  after_create :assign_default_site_role

  scope :admin, -> { 
    joins(:site_role).where(site_roles: { role: SiteRole.roles[:admin] })
  }

  def site_admin?
    site_role&.admin?
  end

  def site_client?
    site_role&.client?
  end

  private

  def assign_default_site_role
    create_site_role!(role: :client)
  end
end
