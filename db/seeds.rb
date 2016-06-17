# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

$user = User.create({
  name: '엄현상',
  issue_num: '0',
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: '2016-01-01 00:00:00',
  issue_num: '0'
})

$user = User.create({
  name: '이산하',
  issue_num: '0',
  email: 'test2@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: '2016-01-01 00:00:00',
  issue_num: '0'
})

$user = User.create({
  name: '샤과봇',
  issue_num: '0',
  email: 'shagwa@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: '2016-01-01 00:00:00'
})

$course = Course.create({
  title: 'Compiler(001)',
  course_num: '4190.409',
  professor_id: 1,
  course_wiki_page: 'Compiler(강의)',
  issue_num: '0'
})

if Issuetag.first.nil?
  Issuetag.create({name: "Project"})
  Issuetag.create({name: "Assignment"})
  Issuetag.create({name: "Quiz"})
  Issuetag.create({name: "Exam"})
  Issuetag.create({name: "Lab"})
  Issuetag.create({name: "Report"})
  Issuetag.create({name: "Notice"})
  Issuetag.create({name: "Question"})
  Issuetag.create({name: "Debate"})
end


Professor.create({
  name:     '버나드 에거',
  picture:  'http://cse.snu.ac.kr/sites/default/files/styles/scale-width-220/public/node--professor/%EB%B2%84%EB%82%98%EB%93%9C%EC%97%90%EA%B1%B0_0.jpg'
})

$crawl_logs = []
$crawl_logs.append CrawlLog.create({url: 'http://www.google.co.k'})
$crawl_logs.append CrawlLog.create({url: 'http://soar.snu.ac.kr/course/board/ds2016'})
$crawl_logs.append CrawlLog.create({url: 'http://mccl.snu.ac.kr/xe/index.php?mid=DataCommunications2016Spring'})
$crawl_logs.append CrawlLog.create({url: 'http://www.nate.com'})

$crawl_logs.each do |crawl_log|
  $course.crawl_logs.append(crawl_log)
end

