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

    respond_to do |format|
      if @course.save
        @course.issue_num = 0;
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/:id
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /courses/:id
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
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
