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

eval_user = User.new(
	:login_id => 'eval',
	:password => 'eval',
	:name => 'user0001',
	:sex => 'male',
	:birthdate => "2002-01-31",
	:cellphone => "010-1234-5678",
	:is_eval => true
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
eval_user.save
test1.save
test2.save

odt1 = OriginalDataType.new(
	:odt_id => test1.task_id,
    :odt_name => "this is sample odt",
    :schema_info => '{"name" : "string", "age" : "integer", "st" : "string"}',
    :mapping_info => '{"name" : "name", "age" : "age", "st" : "st"}'
	)


odt2 = OriginalDataType.new(
	:odt_id => test2.task_id,
    :odt_name => "this is sample odt",
    :schema_info => '{"name" : "string", "age" : "integer", "st" : "string"}',
    :mapping_info => '{"name" : "name", "age" : "age", "st" : "st"}'
	)

odt1.save
odt2.save


specify1 = Specify.new(
	:odt_id => odt1.odt_id,
	:task_id => test1.task_id
	)

specify2 = Specify.new(
	:odt_id => odt2.odt_id,
	:task_id => test2.task_id
	)

specify1.save
specify2.save

if not admin_user.save
  puts "admin save went wrong"
end