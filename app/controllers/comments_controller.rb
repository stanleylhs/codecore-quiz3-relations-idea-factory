# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  idea_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CommentsController < ApplicationController
  before_action :authenticate_user
  def create
    @idea        = Idea.find params[:idea_id]
    @comment          = Comment.new comment_params
    @comment.idea = @idea
    @comment.user     = current_user
    @comment.save ? flash[:notice] = "Commnet Added" : flash[:alert] = "Error, comment not added"
    redirect_to @idea
  end

  def destroy
    idea = Idea.find params[:idea_id]
    comment = Comment.find params[:id]
    # binding.remote_pry
    # if idea.user == current_user
    #   comment = idea.comments.find params[:id]
    # else
    #   comment = current_user.comments.find params[:id]
    # end
    if can? :manage, comment
      comment.destroy
      flash[:notice] = "Comment deleted."
    else
      flash[:alert] = "Access denied"
    end

    redirect_to idea
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
