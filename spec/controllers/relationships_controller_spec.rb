require "rails_helper"

RSpec.describe RelationshipsController, :type => :controller do
  describe "POST create" do
    it "redirige a aquellos que no han hecho login" do
      post :create
      expect(response).to redirect_to("/login")
    end
  end

  describe "DELETE destroy" do
    it "redirige a aquellos que no han hecho login" do
      delete :destroy
      expect(response).to redirect_to("/login") 
    end
  end
end