# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({
  name: '엄현상',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: '2016-01-01 00:00:00'
})

Course.create({
  title: 'Compiler(001)',
  course_num: '4190.409',
  issue_num: '0'
})
