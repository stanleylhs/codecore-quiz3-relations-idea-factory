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

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user_id, uniqueness: {scope: :idea_id}
  validates_with Validators::CannotIfOwn
end
