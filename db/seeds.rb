# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include FactoryGirl::Syntax::Methods

HelpRequest.delete_all
User.delete_all
Authorization.delete_all

users = create_list(:user_with_authorization, 25)
users.shuffle!

users.each do |user|
  create(:help_request, user: user)
end