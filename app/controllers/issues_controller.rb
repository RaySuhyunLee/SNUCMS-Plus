class IssuesController < ApplicationController
  before_action :set_parent
  before_action :set_issue, only: [:show, :update, :destroy, :subscribe]
  before_action :set_regex, only: [:show]
  before_action :set_comments, only: [:show, :update]

  # GET /(parent_type)/:(parent_id)/issues
  def index
    @issues = @parent.issues.all
  end

  # GET /(parent_type)/:(parent_id)/issues/:id
  def show
    unless @issue.nil?
      @comments = @issue.comments.all
    end
    if is_subscribing?
      @subscribe_button_text = "un좋아요"
    else
      @subscribe_button_text = "좋아요"
    end
  end

  # GET /(parent_type)/:(parent_id)/issues/new
  def new
    @issue = @parent.issues.new
    @comment = @issue.comments.new
  end

  # Freezed
  # GET /(parent_type)/:(parent_id)/issues/:id/edit
  #def edit
  #end

  # POST /(parent_type)/:(parent_id)/issues/
  def create
    @issue = @parent.issues.new(issue_params)
    @parent.update_attribute(:issue_num, @parent.issue_num + 1)
    @issue.parent_issue_id = @parent.issue_num

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
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to @index_path, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /(parent_type)/:(parent_id)/issues/:id/subscribe
  def subscribe
    user = current_user
    response = ''
    if is_subscribing?
      user.issues.destroy(@issue)
      response = 'unsubscribed'
    else
      response = 'subscribed'
      user.issues.append(@issue)
    end

    respond_to do |format|
      format.html { redirect_to @issue_path }
      format.json { render json: { response: response } }
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

  # Find issue with url parameters.
  # The parameter :id not means issue_id, but parent_issue_id.
  def set_issue
    # freezed @edit_path = edit_course_issue_path(params[:course_id], params[:id])
    if @parent_name == "Course"
      @issue = Issue.where("have_issue_id = ? AND have_issue_type = ? AND parent_issue_id = ?", params[:course_id], "Course", params[:id]).first
      @issue_path = course_issue_path(@issue.have_issue_id, @issue.parent_issue_id)
    end
  end

  # Set comment path.
  def set_comments
    if @parent_name == "Course"
      @comments_path = course_issue_comments_path(params[:course_id], params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue).permit!
  end

  # GET /(parent_type)/:(parent_id)/issues/:id/subscribe
  def is_subscribing?
    user = current_user
    return user.issues.exists? @issue.id
  end

  def set_regex
    @regex =
    {
      link: /\[\[([^\]]*)\]\]/,
      redirect: /^redirect \[\[(.*)\]\]/,
      latex: /(?<!\\)\$(.*)\$/
    }
  end

end
