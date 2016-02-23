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

require "rails_helper"

RSpec.describe PicturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pictures").to route_to("pictures#index")
    end

    it "routes to #new" do
      expect(:get => "/pictures/new").to route_to("pictures#new")
    end

    it "routes to #show" do
      expect(:get => "/pictures/1").to route_to("pictures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pictures/1/edit").to route_to("pictures#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pictures").to route_to("pictures#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pictures/1").to route_to("pictures#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pictures/1").to route_to("pictures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pictures/1").to route_to("pictures#destroy", :id => "1")
    end

  end
end
