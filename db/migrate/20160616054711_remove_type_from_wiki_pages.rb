class RemoveTypeFromWikiPages < ActiveRecord::Migration
  def change
    rename_column :wiki_pages, :type, :page_type
  end
end
