# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MembershipsController < ApplicationController
    before_action :authenticate_user

  def create
    idea = Idea.find params[:idea_id]
    membership = Membership.new 
    membership.user = current_user
    membership.idea = idea
    flash = (membership.save) ? {notice: "Joined idea!"} : {alert: "Error!"}
    redirect_to idea_path(idea), flash
  end

  def destroy
    idea = Idea.find params[:idea_id]
    membership = current_user.memberships.find params[:id]
    membership.destroy
    redirect_to idea_path(idea), notice: "Leaved idea!"
  end

end
