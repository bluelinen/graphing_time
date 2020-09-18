require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/users").to route_to("users#index")
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/users").to route_to("users#create")
    end

    it "routes to #add_friend" do
      expect(post: "/users/1/add_friend").to route_to("users#add_friend", id: '1')
    end

    it "routes to #search" do
      expect(get: "users/1/search").to route_to("users#search", id: '1')
    end
  end
end
