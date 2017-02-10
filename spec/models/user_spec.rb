require "rails_helper"

RSpec.describe User, :type => :model do
  context "usuario sin relacionar" do
  	before do
      @user = FactoryGirl.build(:example_user)
    end

    it "debería ser válido" do
      expect(@user).to be_valid
    end

    it "debería tener nombre" do
      @user.name = ""
      expect(@user).not_to be_valid
    end

    it "debería tener email" do
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "debería tener un nombre con 50 caracteres máximo" do
      @user.name = "a" * 51
      expect(@user).not_to be_valid
    end

    it "debería tener un email con 255 caracteres máximo" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user).not_to be_valid
    end

    it "debería tener como email una dirección de correo válida" do
      direcciones_validas = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      direcciones_validas.each do |direccion|
        @user.email = direccion
        expect(@user).to be_valid
      end
    end

    it "debería no aceptar direcciones de correo inválida" do
      direcciones_invalidas = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      direcciones_invalidas.each do |direccion|
        @user.email = direccion
        expect(@user).not_to be_valid
      end
    end

    it "debería tener un email único" do
      usuario_duplicado = @user.dup
      usuario_duplicado.email = @user.email.upcase
      @user.save
      expect(usuario_duplicado).not_to be_valid
    end

    it "debería tener el email en minúsculas al ser guardado" do
      email_no_minusculas = "Foo@ExAMPle.CoM"
      @user.email = email_no_minusculas
      @user.save
      expect(email_no_minusculas.downcase).to eq @user.reload.email
    end

    it "debería tener contraseña y corresponderse con la confirmación" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).not_to be_valid
    end

    it "debería tener contraseña de mínimo 6 caracteres" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
    end

    it "debería devolver nil cuando se invoca su método authenticate? con un digest vacío" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user.authenticated?(:remember, '')).to eq false
    end
  end

  context "relaciones entre usuarios" do
    before do
      @michael = FactoryGirl.build(:michael)
      @archer = FactoryGirl.build(:archer)
    end

    it "michael ni archer siguen a nadie, luego michael sigue dos veces a archer mientras archer lo sigue y luego michael deja de seguirlo" do
      expect(@michael.following?(@archer)).to eq false
      expect(@archer.following?(@michael)).to eq false
      expect(@michael.followed?(@archer)).to eq false
      expect(@archer.followed?(@michael)).to eq false
      expect(@michael.following.count).to eq 0
      expect(@michael.followers.count).to eq 0
      expect(@archer.following.count).to eq 0
      expect(@archer.followers.count).to eq 0
      @michael.follow(@archer)
      @michael.follow(@archer)
      @archer.follow(@michael)
      expect(@michael.following?(@archer)).to eq true
      expect(@archer.following?(@michael)).to eq true
      expect(@michael.followed?(@archer)).to eq true
      expect(@archer.followed?(@michael)).to eq true
      expect(@michael.following.count).to eq 1
      expect(@michael.followers.count).to eq 1
      expect(@archer.following.count).to eq 1
      expect(@archer.followers.count).to eq 1
      @michael.unfollow(@archer)
      expect(@michael.following?(@archer)).to eq false
      expect(@archer.following?(@michael)).to eq true
      expect(@michael.followed?(@archer)).to eq true
      expect(@archer.followed?(@michael)).to eq false
      expect(@michael.following.count).to eq 0
      expect(@michael.followers.count).to eq 1
      expect(@archer.following.count).to eq 1
      expect(@archer.followers.count).to eq 0
    end
  end

  #test feed
  context "feed de posts" do
    before do
      @michael = FactoryGirl.create(:michael)
      @archer = FactoryGirl.create(:archer)
      @micropost_3 = @michael.microposts.create(content: "Lorem ipsum 3", created_at: Time.zone.now - 10.days)
      @micropost_2 = @archer.microposts.create(content: "Lorem ipsum 2", created_at: Time.zone.now - 5.days)
      @micropost_1 = @michael.microposts.create(content: "Lorem ipsum 1", created_at: Time.zone.now)
      @michael.follow(@archer)
    end

    it "debería funcionar correctamente" do
      expect(@michael.feed).to eq [@micropost_1, @micropost_2, @micropost_3] 
    end
  end
end