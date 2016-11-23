class AddReportToExperiences < ActiveRecord::Migration[5.0]
  def change
  	add_column :experiences, :report, :boolean, default: false
  end
end
