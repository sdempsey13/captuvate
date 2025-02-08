class AddIndexToDomains < ActiveRecord::Migration[8.0]
  def change
    add_index :domains, :user_id
    add_foreign_key :domains, :users
  end
end
