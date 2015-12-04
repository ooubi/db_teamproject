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
  :birthdate => "1970-01-01",
  :cellphone => "010-1111-1111",
  :is_admin => true
)

submit_user = User.new(
	:login_id => 'submit',
	:password => 'submit',
	:name => 'user0000',
	:sex => 'female',
	:birthdate => "2002-01-31",
	:cellphone => "010-1234-5678",
	:is_submit => true
)

test1 = Task.new(
	:task_name => 'test1',
	:description => 'this is test1',
	:min_upload_period_hour => 24,
	:tdt_name => 'table',
	:tdt_schema_info => '{"name" : "string", "age" : "integer", "st" : "string"}',
	:active => true
	)

test2 = Task.new(
	:task_name => 'test2',
	:description => 'this is test2',
	:min_upload_period_hour => 24,
	:tdt_name => 'table',
	:tdt_schema_info => '{"name" : "string", "age" : "integer", "st" : "string"}',
	:active => false
	)

submit_user.save
test1.save
test2.save


if not admin_user.save
  puts "admin save went wrong"
end