class AddUniquenessIndexesToMemberships < ActiveRecord::Migration[8.0]
  def change
    remove_index :organization_memberships, :user_id, if_exists: true
    add_index :organization_memberships, :user_id, unique: true
    add_index :workspace_memberships, [:user_id, :workspace_id], unique: true
  end
end
