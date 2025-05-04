class ChangeCollectsDefaultsOnDomains < ActiveRecord::Migration[8.0]
  def change
    change_column_default :domains, :collects_desktop, from: false, to: true
    change_column_default :domains, :collects_mobile, from: false, to: true
  end  
end
