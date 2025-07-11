class AddUniqueIndexToWorkspacesOrganizationIdAndName < ActiveRecord::Migration[8.0]
  def change
    add_index :workspaces, [:organization_id, :name], unique: true
  end
end
