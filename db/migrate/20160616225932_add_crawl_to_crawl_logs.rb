class AddCrawlToCrawlLogs < ActiveRecord::Migration
  def change
    add_column :crawl_logs, :crawl, :boolean, default: false
  end
end
