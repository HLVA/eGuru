class Experience < ApplicationRecord
	# mount_uploader :photos, AvatarUploader
	has_many :photos
	accepts_nested_attributes_for :photos, :allow_destroy => true
	belongs_to :user
	
	def self.search(search) 
		 where("title ILIKE ?","%#{search}%")
		 where("content ILIKE ?","%#{search}%") 
	end
end
