class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.string :title
      t.text :content
      t.string :location
      t.integer :rating
      t.integer :user_id
      t.integer :category_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
