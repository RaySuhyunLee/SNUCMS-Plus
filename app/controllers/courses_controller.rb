class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :subscribe]

  # GET /courses 
  def index
    @courses = Course.all
  end

  # GET /courses/:id
  def show
    if is_subscribing?
      @subscribe_button_text = "폭풍드랍!"
    else
      @subscribe_button_text = "수강"
    end
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
    user = current_user
    response = ''
    if is_subscribing?
      response = 'unsubscribed'
      user.courses.destroy(@course)
    else
      response = 'subscribed'
      user.courses.append(@course)
    end

    respond_to do |format|
      format.html { redirect_to course_path(@course) }
      format.json { render json: { response: response } }
    end
  end

  private
  # Find course with url parameters.
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:course_num, :title, :description)
  end

  def is_subscribing?
    user = current_user
    return user.courses.exists? @course.id
  end
end
