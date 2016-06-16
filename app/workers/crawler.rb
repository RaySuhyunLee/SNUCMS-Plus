require 'open-uri'

class Crawler
  include Sidekiq::Worker

  def self.perform
    CrawlLog.all.each do |site|
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
        issue = parent.issues.create({
          title: '변경 사항이 있습니다.',
          due: Time.now
        })
        issue.parent_issue_id = parent.issue_num

        # append Notice tag to issue
        issuetag = Issuetag.find_by(name: 'Notice')
        unless issuetag.nil?
          issue.issuetags.append(issuetag)
        end

        site.save
        issue.save
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
