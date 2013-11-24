require 'securerandom'

class Profile < ActiveRecord::Base
	
	validates_presence_of :nick
	validates_uniqueness_of :nick
	
	belongs_to :account
	
	acts_as_mappable default_units: :kms, default_formula: :sphere, lat_column_name: :latitude, lng_column_name: :longitude
	
	mount_uploader :image, FeedImageUploader
  
  after_initialize :set_default_nick
  
  def to_s
    "profile: #{self.nick}, lat: #{self.latitude}, lng: #{self.longitude}"
  end
  
  private
    def set_default_nick
      self.nick ||= SecureRandom.uuid
    end
  
	# before_validation :geocode_address, on: :create
	
	# private
	# def geocode_address
	# 	geo = Geokit::Geocoders::MultiGeocoder.reverse_geocode self.latitude, self.longitude
	# 	self.location = geo.full_address
	# end
	
end
