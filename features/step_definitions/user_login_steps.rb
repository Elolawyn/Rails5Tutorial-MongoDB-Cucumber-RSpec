Cuando(/^se dirige a la página de login$/) do
  visit '/login'
end

Cuando(/^introduce información errónea$/) do
  fill_in 'session_email', with: 'sdfsdvsdcds'
  fill_in 'session_password', with: 'sfdssdvsd'
  #check 'Remember me on this computer'
  find('input[name="commit"]').click
end

Entonces(/^no inicia sesión$/) do
  expect(current_path).to eq '/login'
  expect(page).to have_text 'Invalid email/password combination'
end

Cuando(/^introduce información correcta$/) do
  fill_in 'session_email', with: 'michael@example.com'
  fill_in 'session_password', with: 'password'
  find('input[name="commit"]').click
  expect(Capybara
    .current_session # Capybara::Session
    .driver          # Capybara::RackTest::Driver
    .request         # Rack::Request
    .cookies         # { "author" => "me" }
    .[]('remember_token')).to eq nil
end

Entonces(/^se inicia sesión$/) do
  expect(current_path).to eq '/users/' + @michael.id
end

Cuando(/^introduce información correcta con remembering$/) do
  fill_in 'session_email', with: 'michael@example.com'
  fill_in 'session_password', with: 'password'
  check 'Remember me on this computer'
  find('input[name="commit"]').click
end

Entonces(/^se recibe una cookie$/) do
  expect(Capybara
    .current_session # Capybara::Session
    .driver          # Capybara::RackTest::Driver
    .request         # Rack::Request
    .cookies         # { "author" => "me" }
    .[]('remember_token')).not_to eq nil
end

Cuando(/^se hage logout$/) do
  visit '/'
  click_on 'Log out'
end

Entonces(/^ya no hay cookie de recuerdo$/) do
  expect(Capybara
    .current_session # Capybara::Session
    .driver          # Capybara::RackTest::Driver
    .request         # Rack::Request
    .cookies         # { "author" => "me" }
    .[]('remember_token')).to eq nil
end
