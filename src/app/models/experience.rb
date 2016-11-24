class Experience < ApplicationRecord
	mount_uploader :photos, AvatarUploader

	# has_many :photos
end
