require "rails_helper"

RSpec.describe SuccessStoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/success_stories").to route_to("success_stories#index")
    end

    it "routes to #new" do
      expect(get: "/success_stories/new").to route_to("success_stories#new")
    end

    it "routes to #show" do
      expect(get: "/success_stories/1").to route_to("success_stories#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/success_stories/1/edit").to route_to("success_stories#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/success_stories").to route_to("success_stories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/success_stories/1").to route_to("success_stories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/success_stories/1").to route_to("success_stories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/success_stories/1").to route_to("success_stories#destroy", id: "1")
    end
  end
end
