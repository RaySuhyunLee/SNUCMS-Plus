class IssuesController < ApplicationController
  before_action :set_parent
  before_action :set_issue, only: [:show, :update, :destroy]
	before_action :set_comments, only: [:show, :new, :update]

  # GET /(parent_type)/:(parent_id)/issues
  # GET /(parent_type)/:(parent_id)/issues.json
  def index
    @issues = @parent.issues.all
  end

  # GET /(parent_type)/:(parent_id)/issues/:id
  # GET /(parent_type)/:(parent_id)/issues/:id.json
  def show
		@comments = @issue.comments.all
  end

  # GET /(parent_type)/:(parent_id)/issues/:id/new
  def new
  	@issue = @parent.issues.new 
  end

	# Freezed
  # GET /(parent_type)/:(parent_id)/issues/:id/edit
	#def edit
	#end

  # POST /(parent_type)/:(parent_id)/issues/
  # POST /(parent_type)/:(parent_id)/issues.json
  def create
    @issue = @parent.issues.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @index_path, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /(parent_type)/:(parent_id)/issues/:id
  # PATCH/PUT /(parent_type)/:(parent_id)/issues/:id.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue_path, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /(parent_type)/:(parent_id)/issues/:id
  # DELETE /(parent_type)/:(parent_id)/issues/:id.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to @index_path, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
	def set_parent
	  parent_type = request.path.split('/')[1]
	  if parent_type == "courses"
	    @parent = Course.find(params[:course_id])
			@parent_name = "Course"
			@index_path = course_issues_path(params[:course_id])
			@new_path = new_course_issue_path(params[:course_id])
	  end
  end
	
	def set_issue
	  @issue = Issue.find(params[:id])
		# freezed @edit_path = edit_course_issue_path(params[:course_id], params[:id])	
	  if @parent_name == "Course"
			@issue_path = course_issue_path(params[:course_id], params[:id])
    end
	end

	def set_comments
		if @parent_name == "Course"
			@comments_path = course_issue_comments_path(params[:course_id], params[:id])
		end
	end
  
	# Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue).permit(:title)
  end
end
