class IssuesController < ApplicationController
  before_action :set_parent
  before_action :set_regex, only: [:show]
  before_action :set_issue, only: [:show, :update, :destroy, :subscribe, :update_title, :update_due]
  before_action :set_comments, only: [:show, :update]

  # GET /(parent_type)/:(parent_id)/issues
  def index
    @issues = @parent.issues.all
    @issues_page = @issues.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /(parent_type)/:(parent_id)/labels/:label
  def index_labels
    @label = params[:label]
    @tag = Issuetag.find_by name: @label
    @issues = []

    unless @label == nil
      @parent.issues.each do |i|
        if i.issuetags.include?(@tag)
          @issues.append(i)
        end
      end
    end
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
    @user_id = current_user.id
  end

  # POST /(parent_type)/:(parent_id)/issues/
  def create
    @issue = @parent.issues.new(issue_params)
    @parent.update_attribute(:issue_num, @parent.issue_num + 1)
    @issue.parent_issue_id = @parent.issue_num
    @issuetags_string = params[:issuetags]
    @issuetags_id = @issuetags_string.split(',')

    @issuetags_id.each do |it|
      @issuetag = Issuetag.find_by_id(it)
      unless @issuetag.nil?
        @issue.issuetags.append(@issuetag)
      end
    end

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @index_path }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /(parent_type)/:(parent_id)/issues/:id/update_title
  def update_title
    @issue.update_attribute(:title, params[:contents])
    render plain: @issue.title
  end

  # POST /(parent_type)/:(parent_id)/issues/:id/update_due
  def update_due
    @issue.update_attribute(:due, params[:due])
    render plain: @issue.due
  end

  # PATCH/PUT /(parent_type)/:(parent_id)/issues/:id
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue_path }
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
      format.html { redirect_to @index_path }
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
      @label_path = "/courses/" + @parent.id.to_s + "/labels" 
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
      issue_link: /#(\d+)/,
      link: /\[\[([^\]]*)\]\]/,
      latex: /(?<!\\)\$(.*)\$/,
      script: /<script>(.*)?<\/script>/m
    }
  end

end
