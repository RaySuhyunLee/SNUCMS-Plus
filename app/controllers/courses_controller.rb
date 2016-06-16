class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :subscribe, :update_description]

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/:id
  def show
    @is_subscribing = is_subscribing?
    if is_subscribing?
      @subscribe_button_text = "드랍!"
    else
      @subscribe_button_text = "수강"
    end

    @crawl_log = CrawlLog.new
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/:id/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.issue_num = 0;

    wiki_name = @course.title.gsub(/(.*)\(\d+\)$/) do $1 end
    wiki_page = WikiPage.link_page(wiki_name, @course.professor)

    unless wiki_page.nil?
      @course.course_wiki_page = wiki_page
    end

    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /courses/:id
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /courses/:id
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  # GET /courses/:id/subscribe
  def subscribe
    subscribe = false
    user = current_user
    if params[:subscribe] == "true"
      subscribe = true
      user.courses.append(@course)
    else
      subscribe = false
      user.courses.destroy(@course)
    end

    respond_to do |format|
      format.all { render json: { subscribe: subscribe } }
    end
  end

  # PATCH /courses/:id/description
  def update_description
    description = params[:description]

    success = @course.update({description: description})

    respond_to do |format|
      format.all { render json: {success: success, description: description} }
    end
  end

  private
  # Find course with url parameters.
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:course_num, :title, :description, :professor_id)
  end

  def is_subscribing?
    user = current_user
    return user.courses.exists? @course.id
  end
end
