class RemoveOrganizationIdFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :organization_id, :bigint
  end
end
