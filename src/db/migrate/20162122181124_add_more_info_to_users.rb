class AddMoreInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthday, :datetime
    add_column :users, :country_id, :integer
  end
end
