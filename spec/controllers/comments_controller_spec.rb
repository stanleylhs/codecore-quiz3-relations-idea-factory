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

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:idea) { create(:idea, {user: user}) }
  let(:idea_1) { create(:idea) }
  # if you pass associates in expilicitly, the default factory assc won't run
  let(:comment)   { create(:comment, {idea: idea, user: user})}
  # use factory assc

  let(:comment_1)   { create(:comment, {idea: idea_1}) }
  let(:comment_2)   { create(:comment, {idea: idea}) }

  #  "Users must be logged in to create or delete comments"
  #  "Creating or deleting comments redirects back to the idea show page"
  #  "Comments get associated with the logged in user"
  #  "Users can only delete their own comments"
  
describe "#create" do
    context "with no signed in user" do
      it "redirects to the sign in page" do
        # idea is outside of comment
        post :create, idea_id: idea.id,
                      comment: attributes_for(:comment)
        expect(response).to redirect_to new_session_path
      end
    end

    context "with signed in user" do
      before { signin(user) }

      context "with valid params" do
        def send_valid_request
          post :create, idea_id: idea.id,
                        comment: attributes_for(:comment)
        end

        it "creates a comment in the database associated with the idea" do
          count_before = idea.comments.count
          send_valid_request
          count_after = idea.comments.count
          expect(count_after - count_before).to eq(1)
        end

        it "associates the comment with the logged in user" do
          send_valid_request
          expect(Comment.last.user).to eq(user)
        end

        it "redirects to the idea show page" do
          send_valid_request
          expect(response).to redirect_to(idea_path(Comment.last.idea))
        end
        # it "sets a flash notice messages"
      end

      context "with invalid params" do
        def invalid_request
          post :create, idea_id: idea.id, comment: { body: ""}
        end
        it "doesn't create a record in the database" do
          comment_count_before = Comment.count
          invalid_request
          comment_count_after = Comment.count
          expect(comment_count_after - comment_count_before).to eq(0)
        end
        it "renders to the idea show page" do 
          invalid_request
          expect(response).to redirect_to(idea_path(idea))      
        end
        it "sets an alert flash message" do
          invalid_request
          expect(flash[:alert]).to be 
        end

      end
    end
  end

  describe "#destroy" do
    context "with no signed in user" do
      it "redirects to the sign in page" do
        delete :destroy, id: comment.id, idea_id: idea.id
        expect(response).to redirect_to new_session_path
      end
    end
    context "with signed in user" do
      before { signin(user) }
      context "with signed in user as the owner of the comment" do
        it "removes the comment from the database" do
          # force create first, NB: let! has too much overhead
          comment
          count_before = Comment.count
          delete :destroy, id: comment.id, idea_id: idea.id
          count_after = Comment.count
          expect(count_after - count_before).to eq (-1)
        end
        it "allows idea owners can delete any comments on their ideas" do
          comment_2
          count_before = Comment.count
          delete :destroy, id: comment_2.id, idea_id: idea.id
          count_after = Comment.count
          expect(count_after - count_before).to eq (-1)
        end
        it "redirects to idea show page" do
          delete :destroy, idea_id: idea.id, id: comment.id
          expect(response).to redirect_to(idea)
        end
      end
      context "with signed in user as not the owner of the comment" do
        before { signin(user) }
        it "doesn't delete the comment" do
          comment_1
          count_before = Comment.count
          # binding.remote_pry
          delete :destroy, id: comment_1.id, idea_id: comment_1.idea_id            
          count_after = Comment.count
          expect(count_after - count_before).to eq (0)
        end
      end
    end
  end
end
