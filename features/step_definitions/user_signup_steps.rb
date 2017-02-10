Cuando(/^un usuario intenta registrase con información inválida$/) do
  visit '/signup'
  fill_in 'user_name', with: ''
  fill_in 'user_email', with: 'user@invalid'
  fill_in 'user_password', with: 'foo'
  fill_in 'user_password_confirmation', with: 'bar'
  click_on 'Create my account'
end

Entonces(/^se muestra un error$/) do
  expect(page).to have_text "Password confirmation doesn't match Password"
  expect(page).to have_text "Name can't be blank"
  expect(page).to have_text "Email is invalid"
  expect(page).to have_text "Password is too short (minimum is 6 characters)"
  expect(page).to have_css 'div#error_explanation'
  expect(page).to have_css 'div.field_with_errors', count: 8
end

Cuando(/^un usuario se registra con información válida$/) do
  visit '/signup'
  fill_in 'user_name', with: 'user'
  fill_in 'user_email', with: 'user@email.com'
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_on 'Create my account'
end

Cuando(/^intenta iniciar sesión$/) do
  log_in_as('user@email.com', 'password', 1)
end

Entonces(/^no puede$/) do
  expect(Capybara
    .current_session # Capybara::Session
    .driver          # Capybara::RackTest::Driver
    .request         # Rack::Request
    .cookies         # { "author" => "me" }
    .[]('remember_token')).to eq nil
end