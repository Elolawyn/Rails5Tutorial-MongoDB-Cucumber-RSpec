require "rails_helper"

RSpec.describe SessionsController, :type => :controller do
  describe "GET new" do
    it "responde con un código 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end
end