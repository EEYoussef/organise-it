require 'rails_helper'

RSpec.describe "Payments", type: :request do
  describe "GET /success" do
    it "returns http success" do
      get "/payments/success"
      expect(response).to have_http_status(:success)
    end
  end

end
