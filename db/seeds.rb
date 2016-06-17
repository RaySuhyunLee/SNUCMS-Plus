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


Professor.create([
  { name: '버나드 에거', picture:  'http://cse.snu.ac.kr/sites/default/files/styles/scale-width-220/public/node--professor/%EB%B2%84%EB%82%98%EB%93%9C%EC%97%90%EA%B1%B0_0.jpg' },
  { name: '강유', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EA%B0%95%EC%9C%A0.png' },
  { name: '권태경', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EA%B6%8C%ED%83%9C%EA%B2%BD%20%EA%B5%90%EC%88%98%EB%8B%98_1.jpg' },
  { name: '김건희', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/GunheeKim-20150115.jpg' },
  { name: '김명수', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EA%B9%80%EB%AA%85%EC%88%98%20%EA%B5%90%EC%88%98%EB%8B%98_7_0.jpg' },
  { name: '김선', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EA%B9%80%EC%84%A0%EA%B5%90%EC%88%98_mod.jpg' },
  { name: '김종권', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EA%B9%80%EC%A2%85%EA%B6%8C%20%EA%B5%90%EC%88%98%EB%8B%98_3_0.jpg' },
  { name: '김지홍', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EA%B9%80%EC%A7%80%ED%99%8D%20%EA%B5%90%EC%88%98%EB%8B%98_30_0.jpg' },
  { name: '김형주', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/hjk55.jpg' },
  { name: '문병로', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EB%AC%B8%EB%B3%91%EB%A1%9C%20%EA%B5%90%EC%88%98%EB%8B%98_17_0.jpg' },
  { name: '문봉기', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/PROF.BONGKIMOON2.jpg' },
  { name: '민상렬', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EB%AF%BC%EC%83%81%EB%A0%AC%20%EC%82%AC%EC%A7%84.jpg' },
  { name: '박근수', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/thumb_kpark.jpg' },
  { name: '스리니바사 라오 사티', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%82%AC%ED%8B%B0%20%EA%B5%90%EC%88%98%EB%8B%98.jpg' },
  { name: '서진욱', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%84%9C%EC%A7%84%EC%9A%B1.jpg' },
  { name: '신영길', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%8B%A0%EC%98%81%EA%B8%B8.jpg' },
  { name: '신현식', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%8B%A0%ED%98%84%EC%8B%9D%20%20%EA%B5%90%EC%88%98%EB%8B%98_8_0.jpg' },
  { name: '엄현상', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%97%84%ED%98%84%EC%83%81%20%EA%B5%90%EC%88%98%EB%8B%98_1%20%283%29_0.jpg' },
  { name: '버나드 에거', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EB%B2%84%EB%82%98%EB%93%9C%EC%97%90%EA%B1%B0_0.jpg' },
  { name: '염현영', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%97%BC%ED%97%8C%EC%98%81%20%20%EA%B5%90%EC%88%98%EB%8B%98_28%20%2811%29_0.jpg' },
  { name: '유석인', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%9C%A0%EC%84%9D%EC%9D%B8%EA%B5%90%EC%88%98%EB%8B%98.jpg' },
  { name: '유승주', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%9C%A0%EC%8A%B9%EC%A3%BC_%EA%B3%A0%ED%95%B4%EC%83%81%EB%8F%84_small.jpg' },
  { name: '이광근', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/________-______.jpg' },
  { name: '이상구', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/SGLee.jpg' },
  { name: '이재진', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%9D%B4%EC%9E%AC%EC%A7%84_0.jpg' },
  { name: '이제희', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%9D%B4%EC%A0%9C%ED%9D%AC%20%20%EA%B5%90%EC%88%98%EB%8B%98_21.jpg' },
  { name: '이창건', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%9D%B4%EC%B0%BD%EA%B1%B4_%ED%8C%9C%ED%94%8C%EB%A0%9B.jpg' },
  { name: '장병탁', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%9E%A5%EB%B3%91%ED%83%81%20%EA%B5%90%EC%88%98%EB%8B%98_22.jpg' },
  { name: '전병곤', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/14-0668_%28%EC%A0%84%EB%B3%91%EA%B3%A4%29.JPG' },
  { name: '전화숙', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%A0%84%ED%99%94%EC%88%99_0.jpg' },
  { name: '최양희', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%EC%B5%9C%EC%96%91%ED%9D%AC%20%EA%B5%90%EC%88%98%EB%8B%98_1%20%283%29_0.jpg' },
  { name: '하순회', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/%ED%95%98%EC%88%9C%ED%9A%8C%20%EA%B5%90%EC%88%98%EB%8B%98%20%283%29_0.jpg' },
  { name: '허충길', picture: 'http://cse.snu.ac.kr/sites/default/files/styles/thumbnail-focus/public/node--professor/gil.jpg' }]
)

$crawl_logs = []
$crawl_logs.append CrawlLog.create({url: 'http://www.google.co.k'})
$crawl_logs.append CrawlLog.create({url: 'http://soar.snu.ac.kr/course/board/ds2016'})
$crawl_logs.append CrawlLog.create({url: 'http://mccl.snu.ac.kr/xe/index.php?mid=DataCommunications2016Spring'})
$crawl_logs.append CrawlLog.create({url: 'http://www.nate.com'})

$crawl_logs.each do |crawl_log|
  $course.crawl_logs.append(crawl_log)
end

