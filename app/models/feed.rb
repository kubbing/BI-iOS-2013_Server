class Feed < ActiveRecord::Base

	validates_presence_of :message

	belongs_to :account
	validates_presence_of :account

	mount_uploader :image, FeedImageUploader
  
	acts_as_mappable default_units: :kms, default_formula: :sphere, lat_column_name: :latitude, lng_column_name: :longitude

end
