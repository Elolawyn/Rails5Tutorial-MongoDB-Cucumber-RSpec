require "rails_helper"

RSpec.describe Micropost, :type => :model do
  context "micropost de un usuario" do
  	before do
      @user = FactoryGirl.build(:michael)
      @micropost_1 = @user.microposts.build(content: "Lorem ipsum", created_at: Time.zone.now - 2.days)
      @micropost_1.save
      @micropost_2 = @user.microposts.build(content: "Lorem ipsum", created_at: Time.zone.now)
      @micropost_2.save
    end

    it "debería ser válido" do
      expect(@micropost_1).to be_valid
    end

    it "el contenido del micropost debería estar presente" do
      @micropost_1.content = ""
      expect(@micropost_1).not_to be_valid
    end

    it "el contenido del micropost debería tener 140 caracteres máximo" do
      @micropost_1.content = "a" * 141
      expect(@micropost_1).not_to be_valid
    end

    it "el propietario del micropost debería ser michael" do
      expect(@micropost_1.user).to eq @user
    end

    it "el orden de los microposts debería ser el más reciente primero" do
      expect(@user.microposts.all).to eq [@micropost_2, @micropost_1]
    end
  end
end