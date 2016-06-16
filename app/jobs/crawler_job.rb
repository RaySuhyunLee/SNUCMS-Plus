class CrawlerJob < ActiveJob::Base
  queue_as :default

  @queue = :crawl

  def self.perform
    puts '---------------------[Crawling...]-----------------------'
    entries = CrawlerLog.All.map do | entry |
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      puts '[URL]:  "' + entry.url + '"'
      puts '[Data]: "' + entry.contents + '"'
      puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    end
  end
end
