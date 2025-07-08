class DropOrganizationRolesTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :organization_roles
  end
end
