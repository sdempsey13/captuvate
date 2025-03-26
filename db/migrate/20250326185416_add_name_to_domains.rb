class AddNameToDomains < ActiveRecord::Migration[8.0]
  def change
    add_column :domains, :name, :string
  end
end
