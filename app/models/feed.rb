class Feed < ActiveRecord::Base

	validates_presence_of :message

	belongs_to :account
	validates_presence_of :account

	mount_uploader :image, FeedImageUploader

end
