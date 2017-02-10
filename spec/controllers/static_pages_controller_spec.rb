require "rails_helper"

RSpec.describe StaticPagesController, :type => :controller do

  describe "GET home" do
    it "responde con un código 200" do
      get :home
      expect(response).to have_http_status(200)
    end

    it "renderiza la plantilla correcta" do
      get :home
      expect(response).to render_template(:home)
    end
  end

  describe "GET about" do
    it "responde con un código 200" do
      get :about
      expect(response).to have_http_status(200)
    end

    it "renderiza la plantilla correcta" do
      get :about
      expect(response).to render_template(:about)
    end
  end

  describe "GET help" do
    it "responde con un código 200" do
      get :help
      expect(response).to have_http_status(200)
    end

    it "renderiza la plantilla correcta" do
      get :help
      expect(response).to render_template(:help)
    end
  end

  describe "GET contact" do
    it "responde con un código 200" do
      get :contact
      expect(response).to have_http_status(200)
    end

    it "renderiza la plantilla correcta" do
      get :contact
      expect(response).to render_template(:contact)
    end
  end
end