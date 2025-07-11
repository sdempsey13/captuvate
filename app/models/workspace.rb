class Workspace < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :organization_id }

  belongs_to :organization

  has_many :workspace_memberships, dependent: :destroy
  has_many :users, through: :workspace_memberships
end
