require 'rails_helper'

RSpec.describe "ProjectOutcomes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/project_outcomes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/project_outcomes/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/project_outcomes/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/project_outcomes/update"
      expect(response).to have_http_status(:success)
    end
  end

end
