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

require 'rails_helper'

RSpec.describe "Ideas", type: :request do
  describe "GET /ideas" do
    it "works! (now write some real specs)" do
      get ideas_path
      expect(response).to have_http_status(200)
    end
  end
end
