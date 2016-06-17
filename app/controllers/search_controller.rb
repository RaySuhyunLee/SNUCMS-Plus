class SearchController < ApplicationController
  def search
    @courses = Course.order(:title).where('title like ?', "%#{params[:query]}%")
    puts @courses
  end
end
