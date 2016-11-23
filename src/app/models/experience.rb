class Experience < ApplicationRecord
	mount_uploader :avatar, AvatarUploader

	belongs_to :photo
end
