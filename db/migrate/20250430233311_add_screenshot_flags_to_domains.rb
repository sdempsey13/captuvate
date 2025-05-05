class AddScreenshotFlagsToDomains < ActiveRecord::Migration[8.0]
  def change
    add_column :domains, :collects_desktop, :boolean, default: false, null: false
    add_column :domains, :collects_mobile, :boolean, default: false, null: false
  end
end
