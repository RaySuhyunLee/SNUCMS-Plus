class CrawlLogsController < ApplicationController
  before_action :get_course, only: [:create, :update, :destroy]
  
  # POST /courses/:course_id/crawl_logs/
  def create
    @crawl_log = @course.crawl_logs.new(crawl_log_params)
    @crawl_log.save
  
    redirect_to @course
  end

  # PATCH /courses/:course_id/crawl_logs/:id
  # PUT /courses/:course_id/crawl_logs/:id
  def update
    crawl_log = @course.crawl_logs.find(params[:id])
    success = crawl_log.update(crawl_log_params) 

    redirect_to @course 
  end

  
  # DELETE /courses/:course_id/crawl_logs/:id
  def destroy
    @course.crawl_logs.destroy(params[:id])

    redirect_to @course
  end

  protected

  def get_course
    @course = Course.find(params[:course_id])
  end

  def crawl_log_params
    params.require(:crawl_log).permit(:url, :crawl)
  end
end
