# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(idea: idea, user: current_user)
    if like.save
      LikesMailer.notify_idea_owner(idea).deliver_later
      redirect_to idea, notice: "Liked!"
    else
      redirect_to idea, alert: "Un-Liked!"
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to idea, notice: "Un-liked!"
  end
end
