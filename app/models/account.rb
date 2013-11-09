class Account < ActiveRecord::Base
	
	validates_presence_of :login
	validates_uniqueness_of :login
	
	validates_presence_of :nick
	validates_uniqueness_of :nick

	has_many :feeds, dependent: :destroy

end
