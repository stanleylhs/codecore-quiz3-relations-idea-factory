class LikesMailer < ApplicationMailer
  def notify_idea_owner(idea)
    # @like = like
    @idea = idea
    @owner = @idea.user
    mail(to: @owner.email, subject: "You got an like!")
  end
end
