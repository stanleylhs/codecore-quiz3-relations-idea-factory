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

# TODO: refactor 
class CannotLikeOwn < ActiveModel::Validator
  def validate(record)
    unless record.user != record.idea.user
      record.errors[:user_id] << "You can't like your own idea!"
      # record.idea.errors[:user_id] << "You can't like your own idea!"
    end
  end
end

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user_id, uniqueness: {scope: :idea_id}
  validates_with CannotLikeOwn
end

