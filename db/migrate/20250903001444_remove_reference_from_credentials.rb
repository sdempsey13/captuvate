class RemoveReferenceFromCredentials < ActiveRecord::Migration[8.0]
  def change
    remove_reference :api_credentials, :organization, foreign_key: true
    remove_reference :webhook_credentials, :organization, foreign_key: true
  end
end
