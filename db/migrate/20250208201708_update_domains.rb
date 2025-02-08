class UpdateDomains < ActiveRecord::Migration[8.0]
  def change
    remove_column :snap_shots, :url, :string
    remove_column :snap_shots, :user_id, :bigint
    rename_column :snap_shots, :page_group_id, :domain_id
    
    add_column :domains, :url, :string, null: false
    add_column :domains, :user_id, :bigint, null: false
  end
end
