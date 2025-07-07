class MakeOrganizationRequiredOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :organization_id, false
  end
end
