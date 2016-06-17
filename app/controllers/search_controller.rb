class SearchController < ApplicationController
  def search
    @courses = Course.order(:title).where('title like ?', "%#{params[:query]}%")
    @wiki_pages = WikiPage.order(:title).where('title like ?', "%#{params[:query]}%")

    @results = []
    
    @courses.each do |c|
      @results.append ({ title: c.title, url: '/courses/' + c.id.to_s, description: "Course" })
    end

    @wiki_pages.each do |w|
      @results.append ({ title: w.title, url: '/wiki/' + w.title, description: "Wiki page" })
    end

    render :json => { "results": @results }
  end
end
