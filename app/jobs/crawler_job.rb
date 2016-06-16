class CrawlerJob < ActiveJob::Base
  queue_as :default

  def perform(name, count)
    puts 'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW'
    sleep(count)
  end
end
