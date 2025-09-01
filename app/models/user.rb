class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :site_role, dependent: :destroy

  has_one :organization_membership, dependent: :destroy
  has_one :organization, through: :organization_membership

  has_many :workspace_memberships, dependent: :destroy
  has_many :workspaces, through: :workspace_memberships

  has_many :domains, dependent: :destroy
  has_many :snap_shots, through: :domains
  has_many :comments, dependent: :destroy

  after_create :assign_default_site_role

  scope :admin, -> {
    joins(:site_role).where(site_roles: { role: SiteRole.roles[:admin] })
  }

  scope :client, -> {
    joins(:site_role).where(site_roles: { role: SiteRole.roles[:client] })
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
