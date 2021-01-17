class CommentsController < ApplicationController
  before_action :require_login, only: :create

  def create
    @comment = current_user.comments.build comment_param
    @message = @comment.save
    respond_to :js
  end

  def destroy; end

  private

  def comment_param
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
