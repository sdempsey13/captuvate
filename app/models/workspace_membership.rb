class WorkspaceMembership < ApplicationRecord
  validates :role, presence: true
  
  belongs_to :user
  belongs_to :workspace

  enum :role, { admin: 0, analyst: 1 }

end
