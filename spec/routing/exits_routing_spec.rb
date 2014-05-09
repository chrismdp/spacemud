require "spec_helper"

describe ExitsController do
  describe "routing" do

    it "routes to #index" do
      get("/exits").should route_to("exits#index")
    end

    it "routes to #new" do
      get("/exits/new").should route_to("exits#new")
    end

    it "routes to #show" do
      get("/exits/1").should route_to("exits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/exits/1/edit").should route_to("exits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/exits").should route_to("exits#create")
    end

    it "routes to #update" do
      put("/exits/1").should route_to("exits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/exits/1").should route_to("exits#destroy", :id => "1")
    end

  end
end
