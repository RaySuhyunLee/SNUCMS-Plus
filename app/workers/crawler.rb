require 'open-uri'

class Crawler
  include Sidekiq::Worker

  def self.perform
    sites = CrawlLog.all.select do |log|
      log if log.crawl
    end

    sites.each do |site|
      puts site.url
      begin
        page = get_page(site.url)
      rescue => e
        puts e.message
      end

      next if page.nil?

      puts 'page valid'

      if site.contents.nil?
        puts 'new page'
        site.contents = page
        site.save
      elsif site.contents != page
        puts 'change detected'
        site.contents = page

        # find parent(course)
        parent = Course.find(site.course_id)
        parent.update_attribute(:issue_num, parent.issue_num + 1)

        # create issue
        issue = parent.issues.create({ title: '변경 사항이 있습니다.' })
        issue.parent_issue_id = parent.issue_num

        # append Notice tag to issue
        issuetag = Issuetag.find_by(name: 'Notice')
        unless issuetag.nil?
          issue.issuetags.append(issuetag)
        end

        comment = issue.comments.new(commenter: '샤과봇', contents: site.url + ' 에서 변경 사항을 확인하세요.')

        site.save
        issue.save
        comment.save
      end
    end
  end

  def self.get_page(url)
    doc = Nokogiri::HTML(open(url)).at('body')

    doc.search('input').each do |node|
      node.remove
    end

    doc.to_s
  end
end
