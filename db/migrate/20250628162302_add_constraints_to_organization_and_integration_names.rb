class AddConstraintsToOrganizationAndIntegrationNames < ActiveRecord::Migration[8.0]
  def change
    change_column_null :organizations, :name, false
    add_index :organizations, :name, unique: true

    change_column_null :integrations, :name, false
    add_index :integrations, :name, unique: true
  end
end