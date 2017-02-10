require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "activación de cuenta" do
    before do
      @user = FactoryGirl.build(:michael)
      @user.activation_token = User.new_token
      @mail = UserMailer.account_activation(@user)
    end

    it "renderiza la cabecera" do
      expect(@mail.subject).to eq("Account activation")
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(["noreply@example.com"])
    end

    it "renderiza el cuerpo" do
      expect(@mail.body.encoded).to match(@user.name)
      expect(@mail.body.encoded).to match(@user.activation_token)
      expect(@mail.body.encoded).to match(CGI.escape(@user.email))
    end
  end

  describe "reseteo de contraseña" do
    before do
      @user = FactoryGirl.build(:michael)
      @user.reset_token = User.new_token
      @mail = UserMailer.password_reset(@user)
    end

    it "renderiza la cabecera" do
      expect(@mail.subject).to eq("Password reset")
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(["noreply@example.com"])
    end

    it "renderiza el cuerpo" do
      expect(@mail.body.encoded).to match(@user.reset_token)
      expect(@mail.body.encoded).to match(CGI.escape(@user.email))
    end
  end
end