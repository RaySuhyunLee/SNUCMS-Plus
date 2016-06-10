class CreateCrawlLogs < ActiveRecord::Migration
  def change
    create_table :crawl_logs do |t|
      t.string :url
      t.text :contents

      t.timestamps null: false
    end
  end
end
