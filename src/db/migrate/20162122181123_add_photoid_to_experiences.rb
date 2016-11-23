class AddPhotoidToExperiences < ActiveRecord::Migration[5.0]
  def change
  	add_column :experiences, :photo_id, :integer
  end
end