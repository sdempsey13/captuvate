class OrganizationRole < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum :role, { admin: 0, analyst: 1 }
end
