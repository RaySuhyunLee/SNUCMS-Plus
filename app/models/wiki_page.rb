class WikiPage < ActiveRecord::Base
  has_paper_trail

  def self.link_page(wiki_name, prof)
    if prof.nil?
      prof_name = ''
    else
      prof_name = '|' + prof.name
    end

    wiki_title = wiki_name + '(강의' + prof_name + ')'
    @page = WikiPage.find_by(title: wiki_title)

    if @page.nil?
      @page = WikiPage.new
      @page.title = wiki_title
      @page.page_type = 'Course'

      unless @page.save
        return nil
      end
    end

    return @page.title
  end
end
