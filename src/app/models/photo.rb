class Photo < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
end
