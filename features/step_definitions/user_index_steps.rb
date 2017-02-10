Dado(/^un usuario admin y 100 usuarios no admins$/) do
  @michael = FactoryGirl.create(:michael)
  @archer = FactoryGirl.create(:archer)
  99.times do |index|
    @archer = FactoryGirl.create(:example_user, email: 'email' + index.to_s + '@algo.com')
  end
end

Cuando(/^el usuario admin inicia sesión$/) do
  log_in_as(@michael.email, 'password', 1)
end

Cuando(/^se dirige a la lista de usuarios$/) do
  visit '/users'
end

Entonces(/^debería ver enlaces de borrado de usuarios y usarlos para borrar$/) do
  expect(User.count).to eq 101
  #expect(page).to have_css 'div.pagination'
  expect(page).to have_text 'delete'
  #javascript
  User.last.delete
  expect(User.count).to eq 100
end

Cuando(/^un usuario no admin inicia sesión$/) do
  log_in_as(@archer.email, 'password', 1)
end

Entonces(/^no debería ver enlaces de borrado de usuarios$/) do
  expect(User.count).to eq 101
  #expect(page).to have_css 'div.pagination'
  expect(page).not_to have_text 'delete'
end
