# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = {
  admin: {
    login_id: 'admin',
    password: 'admin',
    name: 'administrator',
    sex: 0,
    birthdate: 1970-01-01,
    cellphone: 010-1111-1111,
    type: 0
	}
}

=begin
	
rescue Exception => e
	
end
There is convenient way for populating tables - db/seed.rb file. Just add the script for creating users in it and run:

rake db:seed
Below you can see example of User model with email and username fields:

# Inserting default security users
users = {

    admin: {

        username: 'admin',
        email: 'admin@gmail.com',
        password: 'adminpass',
        password_confirmation: 'adminpass',
        is_admin: true
    },

    administrator: {

        username: 'administrator',
        email: 'administrator@gmail.com',
        password: 'administrator',
        password_confirmation: 'administrator',
        is_admin: true
    }
}

users.each do |user, data|

  user = User.new(data)

  unless User.where(email: user.email).exists?
    user.save!
  end
end

=end