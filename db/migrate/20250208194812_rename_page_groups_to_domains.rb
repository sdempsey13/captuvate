class RenamePageGroupsToDomains < ActiveRecord::Migration[8.0]
  def change
    rename_table :page_groups, :domains
    rename_table :pages, :snap_shots
  end
end

