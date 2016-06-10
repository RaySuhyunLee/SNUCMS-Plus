# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

$user = User.create({
  name: '엄현상',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: '2016-01-01 00:00:00'
})

$course = Course.create({
  title: 'Compiler(001)',
  course_num: '4190.409',
  issue_num: '0'
})

$i = 0
while $i < 20 do
  issue = Issue.create({title: $i.to_s, parent_issue_id: $i}) 
  $course.issues.append(issue)
  $user.issues.append(issue)
  $i+=1
end


Professor.create({
  name:     '버나드 에거',
  picture:  'http://cse.snu.ac.kr/sites/default/files/styles/scale-width-220/public/node--professor/%EB%B2%84%EB%82%98%EB%93%9C%EC%97%90%EA%B1%B0_0.jpg'
})

School.create({
  name: 'SNU'
})
