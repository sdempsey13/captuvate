class WorkspaceMembership < ApplicationRecord
  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :workspace_id }
  validate :user_must_belong_to_workspace_org
  
  belongs_to :user
  belongs_to :workspace

  enum :role, { admin: 0, analyst: 1 }

  private

  def user_must_belong_to_workspace_org
    if user.organization != workspace.organization
      errors.add(:base, 'User must belong to the same organization as the workspace')
    end
  end
end
