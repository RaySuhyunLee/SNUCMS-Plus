class CommentsController < ApplicationController
  before_action :set_issue
  before_action :set_comment, only: [:update, :destroy, :get_contents, :update_contents]

  # GET /(parent_type)/:(parent_id)/issues/:issue_id/comments/:id/get_contents
  def get_contents
   render plain: @comment.contents 
  end

  # POST /(parent_type)/:(parent_id)/issues/:issue_id/comments
  # POST /(parent_type)/:(parent_id)/issues/:issue_id/comments.json
  def create
    @comment = @issue.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @issue_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /(parent_type)/:(parent_id)/issues/:issue_id/comments/:id/update_contents
  def update_contents
    if @comment.update_attribute(:contents, params[:contents])
      render :text => "Contents is updated!"
    else
      render :text => "Contents is not updated!"
    end
  end

  # PATCH/PUT /(parent_type)/:(parent_id)/issues/:issue_id/comments/1
  # PATCH/PUT /(parent_type)/:(parent_id)/issues/:issue_id/comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @issue_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /(parent_type)/:(parent_id)/issues/:issue_id/comments/1
  # DELETE /(parent_type)/:(parent_id)/issues/:issue_id/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @issue_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    parent_type = request.path.split('/')[1]
    if parent_type == "courses"
      @issue = Issue.where("have_issue_id = ? AND have_issue_type = ? AND parent_issue_id = ?", params[:course_id], "Course", params[:issue_id]).first
      @issue_path = course_issue_path(@issue.have_issue_id, @issue.parent_issue_id)
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:contents, :commenter, :issue_id)
  end
end
