json.extract! photo, :id, :content, :link, :avatar, :user_id, :question_id, :experience_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)