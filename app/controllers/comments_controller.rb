class CommentsController < ApplicationController
  before_action :set_issue
  before_action :set_comment, only: [:update, :destroy]

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
      @issue_path = course_issue_path(params[:course_id], params[:issue_id])
    end
    @issue = Issue.find(params[:issue_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:contents, :commenter, :issue_id)
  end
end