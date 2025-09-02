class RenameIntegrationCredentialsToApiCredentials < ActiveRecord::Migration[8.0]
  def change
    rename_table :integration_credentials, :api_credentials
  end
end
