# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe "Pictures", type: :request do
  describe "GET /pictures" do
    it "works! (now write some real specs)" do
      get pictures_path
      expect(response).to have_http_status(200)
    end
  end
end
