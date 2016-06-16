class AddWikiToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_wiki_page, :string
  end
end
