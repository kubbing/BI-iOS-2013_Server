# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Push::ConfigurationApns.delete_all

case Rails.env
when "development"
	Push::ConfigurationApns.create(
		app: 'cz.cvut.fit.bi-ios.apns', 
		connections: 2, 
		enabled: true,
		certificate: File.read('certificates/sandbox.pem', encoding: 'BINARY'),
		feedback_poll: 60,
		sandbox: true
	)
when "production"
	Push::ConfigurationApns.create(
		app: 'cz.cvut.fit.bi-ios.apns', 
		connections: 2, 
		enabled: true,
		certificate: File.read('certificates/production.pem', encoding: 'BINARY'),
		feedback_poll: 60,
		sandbox: false
	)
end