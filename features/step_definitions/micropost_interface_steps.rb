Dado(/^un usuario michael que tiene un micropost$/) do
  @michael = FactoryGirl.create(:michael)
  @michael.microposts.create(content: "Hola")
  @archer = FactoryGirl.create(:archer)
end

Cuando(/^el usuario se loguea$/) do
  log_in_as(@michael.email, 'password', 1)
  visit '/'
end

Entonces(/^debería ver en la página inicial que dispone de un micropost$/) do
  expect(page).to have_css 'input[type=file]'
  expect(page).to have_text "1 micropost"
end

Cuando(/^el usuario se loguea y borra su micropost$/) do
  log_in_as(@michael.email, 'password', 1)
  @michael.microposts.first.delete()
  visit '/'
end

Entonces(/^debería ver en la página inicial que no tiene microposts$/) do
  expect(page).to have_text "0 microposts"
end

Cuando(/^el usuario se loguea y crea un micropost con errores$/) do
  log_in_as(@michael.email, 'password', 1)
  visit '/'
  fill_in 'micropost_content', with: ""
  click_on 'Post'
end

Entonces(/^debería ver un error$/) do
  expect(page).to have_css 'div#error_explanation'
end

Entonces(/^debería ver su lista de posts paginada$/) do
  expect(page).to have_text "100 microposts"
  expect(page).to have_css 'div.pagination'
end

Cuando(/^el usuario se loguea y crea un micropost correctamente$/) do
  expect(@michael.microposts.count).to eq 0
  @contenido = 'contenido del post'
  log_in_as(@michael.email, 'password', 1)
  visit '/'
  fill_in 'micropost_content', with: @contenido
  click_on 'Post'
end

Entonces(/^el micropost se crea$/) do
  @michael.reload
  expect(page).to have_text @contenido
  expect(@michael.microposts.count).to eq 1
end
