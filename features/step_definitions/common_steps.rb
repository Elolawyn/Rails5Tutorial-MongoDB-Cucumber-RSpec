Dado(/^un usuario michael$/) do
  @michael = FactoryGirl.create(:michael)
end

Dado(/^un usuario michael que tiene 100 microposts$/) do
  @michael = FactoryGirl.create(:michael)
  100.times do 
    @michael.microposts.create(content: "Hola")
  end
end