class OrganizationMembership < ApplicationRecord
  validates :user_id, uniqueness: { scope: :organization_id }
  
  belongs_to :user
  belongs_to :organization

  enum :role, { admin: 0, analyst: 1 }
end
