class Workspace < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :organization_id }

  belongs_to :organization
  validates :organization, presence: true

  has_many :workspace_memberships, dependent: :destroy
  has_many :users, through: :workspace_memberships

  has_many :integrations, dependent: :destroy
  has_many :api_credentials, through: :integrations
  has_many :webhook_credentials, through: :integrations
end
