class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :subscribe]

  # GET /courses 
  def index
    @courses = Course.all
  end

  # GET /courses/:id
  def show
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

  # GET /courses/:id/subscribe.json 
  def subscribe
    user = current_user
    response = ''
    if user.courses.exists?(@course.id)
      response = 'already_exists'
    else
      response = 'ok'
      user.courses.append(@course)
    end

    respond_to do |format|
      format.json { render json: { response: response } }
    end
  end

  private
  # Find course with url parameters.
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:university, :classification, :college, :department, :level, :grade, :course_num, :lecture_num, :title, :credit, :timetable, :location)
  end
end
