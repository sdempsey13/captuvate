class CommentsController < ApplicationController
  def create
    @comment = Comment.new(user_id: params[:user_id], snap_shot_id: params[:snap_shot_id], content: params[:content])
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.expect(:user_id, :snap_shot_id, :content)
  end
end