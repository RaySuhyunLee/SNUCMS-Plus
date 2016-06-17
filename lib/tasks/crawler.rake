
desc 'Periodical Crawling Worker'
task crawler: :environment do
  Crawler.perform
end
