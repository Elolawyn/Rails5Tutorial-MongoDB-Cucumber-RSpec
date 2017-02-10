require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  before do
    @michael = FactoryGirl.create(:michael)
    @archer = FactoryGirl.create(:archer)
  end

  describe "GET new" do
    it "devuelve código 200" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "GET index" do
    it "redirige cuando no se ha logeado" do
      get :index
      expect(flash.empty?).to be false
      expect(response).to redirect_to("/login")
    end
  end

  describe "GET following" do
    it "redirige cuando no se ha logeado" do
      get :following, params: { id: @michael }
      expect(flash.empty?).to be false
      expect(response).to redirect_to("/login")
    end
  end

  describe "GET followers" do
    it "redirige cuando no se ha logeado" do
      get :followers, params: { id: @michael }
      expect(flash.empty?).to be false
      expect(response).to redirect_to("/login")
    end
  end

  describe "GET edit" do
    it "redirige cuando no se ha logeado" do
      get :edit, params: { id: @michael.id }
      expect(flash.empty?).to be false
      expect(response).to redirect_to("/login")
    end

    it "redirige cuando el usuario no es el correcto" do
      log_in_as(@archer)
      get :edit, params: { id: @michael.id }
      expect(flash.empty?).to be true
      expect(response).to redirect_to("/")
    end
  end

  describe "PATCH update" do
    it "redirige cuando no se ha logeado" do
      patch :update, params: { id: @michael.id, user: { name: @michael.name, email: @michael.email } }
      expect(flash.empty?).to be false
      expect(response).to redirect_to("/login")
    end

    it "redirige cuando el usuario no es el correcto" do
      log_in_as(@archer)
      patch :update, params: { id: @michael.id, user: { name: @michael.name, email: @michael.email } }
      expect(flash.empty?).to be true
      expect(response).to redirect_to("/")
    end

    it "no debería permitir actualización de estado de admin" do
      log_in_as(@archer)
      expect(@archer.admin).to eq false
      patch :update, params: { id: @archer.id, user: { password: 'password', password_confirmation: 'password', admin: true } }
      @archer.reload
      expect(@archer.admin).to eq false
    end
  end

  describe "DELETE destroy" do
    it "redirige cuando no se ha logeado" do
      expect(User.count).to be 2
      delete :destroy, params: { id: @michael }
      expect(User.all.count).to be 2
      expect(flash.empty?).to be false
      expect(response).to redirect_to("/login")
    end

    it "redirige cuando el usuario no es administrador" do
      log_in_as(@archer)
      expect(User.count).to be 2
      delete :destroy, params: { id: @michael }
      expect(User.all.count).to be 2
      expect(response).to redirect_to("/")
    end

    it "funciona correctamente" do
      log_in_as(@michael)
      expect(User.count).to be 2
      delete :destroy, params: { id: @archer }
      expect(User.all.count).to be 1
      expect(response).to redirect_to("/users")
    end
  end
end