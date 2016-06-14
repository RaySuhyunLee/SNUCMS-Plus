class AddTypeToWikiPages < ActiveRecord::Migration
  def change
    add_column :wiki_pages, :type, :string
  end
end
