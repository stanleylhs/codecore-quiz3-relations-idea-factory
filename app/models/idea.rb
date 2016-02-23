# == Schema Information
#
# Table name: ideas
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Idea < ActiveRecord::Base
  belongs_to :user
  
  has_many :likes, dependent: :destroy
  
  has_many :memberships, dependent: :destroy
  has_many :joined_users, through: :memberships, source: :user

  has_many :comments, dependent: :destroy

  has_many :pictures, dependent: :destroy
  
  def like_for(user)
    likes.find_by_user_id user
  end
  def membership_for(user)
    memberships.find_by_user_id user
  end

  delegate :full_name, to: :user, prefix: true, allow_nil: :true
end
