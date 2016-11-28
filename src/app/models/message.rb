class Message < ActiveRecord::Base
 belongs_to :conversation
 belongs_to :user

 validates_presence_of :body, :conversation_id, :user_id
after_create_commit { MessageBroadcastJob.perform_now(self) }
 def message_time
  created_at.strftime('%m/%d/%y at %l:%M %p')
 end

   def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

end