require "rails_helper"

RSpec.describe SessionsHelper, :type => :helper do
  describe "current_user" do
    before do
      @user = FactoryGirl.build(:michael)
      remember(@user)
    end

    it "devuelve el usuario correcto cuando recuerda la sesión" do
      expect(current_user).to eq @user
      expect(!session[:user_id].nil?).to be true
    end

    it "devuelve nil cuando el remember digest no es correcto" do
      @user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be nil
    end
  end
end