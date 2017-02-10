require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "full_title" do
    it "devuelve el titulo por defecto" do
      expect(helper.full_title).to eq "Ruby on Rails Tutorial Sample App"
    end

    it "devuelve un título personalizado" do
      expect(helper.full_title("Hola")).to eq "Hola | Ruby on Rails Tutorial Sample App"
    end
  end
end