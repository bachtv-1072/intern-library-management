class CommentsController < ApplicationController
  before_action :require_login, only: %i(create destroy)

  def create
    @comment = current_user.comments.build comment_params
    @message = @comment.save
    respond_to :js
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
