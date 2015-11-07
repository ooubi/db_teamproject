# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.new(
  :login_id => 'admin',
  :password => 'admin',
  :name => 'administrator',
  :sex => 'female',
  :birthdate => 1970-01-01,
  :cellphone => 010-1111-1111,
  :user_type => 'admin'
)

if admin_user.save
  puts "admin save went wrong"
end