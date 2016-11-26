class ChangeTypeOfUserCountry < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :country_id, :country_code
    change_column :users, :country_code, :string
  end
end
