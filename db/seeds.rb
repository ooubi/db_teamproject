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

sample_task = Task.new(
	:task_name => '카드로그 수집',
	:description => '개인 카드 사용자의 국내 카드 사용 로그를 수집합니다.',
	:min_upload_period_hour => 720,
	:tdt_name => 'CARD_LOG_COLLECTION',
	:tdt_schema_info => '{"PRESENTOR" : "varchar(15)", "TIMESTAMP" : "datetime", "CARD_MEM_STORE" : "varchar(20)", "CARD_USE_MONEY" : "integer"}',
	:active => true
	)

submit_user.save
eval_user.save
test1.save
test2.save
sample_task.save

odt1 = OriginalDataType.new(
    :odt_name => "this is sample odt",
    :schema_info => '{"name" : "string", "age" : "integer", "st" : "string"}',
    :mapping_info => '{"name" : "name", "age" : "age", "st" : "st"}'
	)


odt2 = OriginalDataType.new(
    :odt_name => "this is sample odt",
    :schema_info => '{"name" : "string", "age" : "integer", "st" : "string"}',
    :mapping_info => '{"name" : "name", "age" : "age", "st" : "st"}'
	)

odt_sample_task_1 = OriginalDataType.new(
    :odt_name => "국민카드",
    :schema_info => '{"이용일시" : "string", "이용일시" : "string", "이용카드명" : "string", "이용하신곳" : "string", "국내이용금액" : "string", "해외이용금액" : "string", "결제방법" : "string", "가맹점정보" : "string", "적립(예상) 포인트리" : "string", "상태" : "string", "결제예정일" : "string", "승인번호" : "string"}',
    :mapping_info => '{"TIMESTAMP" : "이용일시", "TIMESTAMP" : "이용일시", "CARD_MEM_STORE" : "이용하신곳", "CARD_USE_MONEY" : "국내이용금액"}'
	)

odt_sample_task_2 = OriginalDataType.new(
    :odt_name => "우리카드",
    :schema_info => '{"이용일자" : "datetime", "이용일자" : "datetime", "카드 구분" : "string", "이용 카드" : "string", "매출 구분" : "string", "이용가맹점(은행)명" : "string", "이용금액 (해외현지/ 체크카드)" : "string", "할부 개월" : "integer", "회차" : "integer", "원금" : "string", "혜택금액" : "string", "환율" : "string", "수수료" : "string", "결제 후 잔액" : "string", "할부가격" : "string"}	',
    :mapping_info => '{"TIMESTAMP" : "이용일자", "TIMESTAMP" : "이용일자", "CARD_MEM_STORE" : "이용가맹점(은행)명", "CARD_USE_MONEY" : "이용금액"}'
	)

odt1.save
odt2.save

odt_sample_task_1.save
odt_sample_task_2.save


specify1 = Specify.new(
	:odt_id => odt1.odt_id,
	:task_id => test1.task_id
	)

specify2 = Specify.new(
	:odt_id => odt2.odt_id,
	:task_id => test2.task_id
	)

specify_sample_task_1 = Specify.new(
	:odt_id => odt_sample_task_1.odt_id,
	:task_id => sample_task.task_id
	)


specify_sample_task_2 = Specify.new(
	:odt_id => odt_sample_task_2.odt_id,
	:task_id => sample_task.task_id
	)

specify1.save
specify2.save
specify_sample_task_1.save
specify_sample_task_2.save

if not admin_user.save
  puts "admin save went wrong"
end