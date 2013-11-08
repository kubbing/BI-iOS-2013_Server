class Feed < ActiveRecord::Base

	mount_uploader :image, FeedImageUploader

end
