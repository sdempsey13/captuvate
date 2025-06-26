class CreateIntegrationCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :integration_credentials do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :integration, null: false, foreign_key: true
      t.text :encrypted_api_key

      t.timestamps
    end
  end
end
