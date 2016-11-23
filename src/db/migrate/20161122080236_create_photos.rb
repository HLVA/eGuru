class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.text :content
      t.string :link
      t.string :avatar
      t.integer :user_id
      t.integer :question_id
      t.integer :experience_id

      t.timestamps
    end
  end
end
