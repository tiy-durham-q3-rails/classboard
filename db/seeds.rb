# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'active_record/fixtures'

HelpRequest.delete_all
User.delete_all
Authorization.delete_all

fixture_set_names = %w(users authorizations help_requests)
ActiveRecord::FixtureSet.create_fixtures("test/fixtures", fixture_set_names)

User.create!(name: "Clinton Dreisbach", email: "clinton@dreisbach.us", teacher: true)