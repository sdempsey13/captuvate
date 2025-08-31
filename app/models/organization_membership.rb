class OrganizationMembership < ApplicationRecord
  validates :user_id, uniqueness: true
  
  belongs_to :organization
  belongs_to :user

  enum :role, { admin: 0, analyst: 1 }
end
