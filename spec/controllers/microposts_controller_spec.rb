require "rails_helper"

RSpec.describe MicropostsController, :type => :controller do
  before do
    @michael = FactoryGirl.create(:michael)
    @archer = FactoryGirl.create(:archer)
    @micropost = @archer.microposts.build(content: "Hola")
    @micropost.save
  end

  describe "POST create" do
    it "redirige a aquellos que no han hecho login" do
      post :create, params: { micropost: { content: "Lorem ipsum" } }
      expect(response).to redirect_to("/login")
    end
  end

  describe "DELETE destroy" do
    it "redirige a aquellos que no han hecho login" do
      delete :destroy, params: { id: "4353" }
      expect(response).to redirect_to("/login") 
    end

    it "redirige a aquellos que no son propietarios del micropost" do
      log_in_as(@michael)
      delete :destroy, params: { id: @micropost.id } 
      @archer.reload
      expect(@archer.microposts.all.count).to eq 1
      expect(response).to redirect_to("/") 
    end
  end
end