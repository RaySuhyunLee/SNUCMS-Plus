class AssociateCrawlLogsToCourses < ActiveRecord::Migration
  def change
    add_belongs_to :crawl_logs, :course, { index: true }
  end
end
