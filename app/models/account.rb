class Account < ActiveRecord::Base
	
	validates_presence_of :login
	validates_uniqueness_of :login
	
	validates_presence_of :profile

	has_many :feeds, dependent: :destroy
	has_one :profile, dependent: :destroy

end
