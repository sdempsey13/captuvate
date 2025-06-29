class AddMaskedApiKeyToIntegrationCredentials < ActiveRecord::Migration[8.0]
  def change
    add_column :integration_credentials, :masked_api_key, :string
  end
end
