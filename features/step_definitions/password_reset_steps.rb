Cuando(/^solicita un reseteo de contraseña correcto$/) do
  reset_digest = @michael.reset_digest
  visit '/password_resets/new'
  fill_in 'password_reset_email', with: @michael.email
  click_on 'Submit'
  expect(page).to have_text 'Email sent with password reset instructions'
  expect(reset_digest).not_to eq @michael.reload.reset_digest
end

Cuando(/^solicita un reseteo de contraseña incorrecto$/) do
  visit '/password_resets/new'
  fill_in 'password_reset_email', with: ''
  click_on 'Submit'
end

Cuando(/^accede a resetearla cuando el token ha expirado$/) do
  @michael.create_reset_digest
  @michael.update_attribute(:reset_sent_at, 3.hours.ago)
  @michael.save
  visit '/password_resets/' + @michael.reset_token + '/edit?email=' + @michael.email
end

Cuando(/^accede a resetearla con el email incorrecto$/) do
  @michael.create_reset_digest
  @michael.save
  visit '/password_resets/' + @michael.reset_token + '/edit?email='
end

Cuando(/^accede a resetearla con el usuario inactivo$/) do
  @michael.create_reset_digest
  @michael.activated = !@michael.activated
  @michael.save
  visit '/password_resets/' + @michael.reset_token + '/edit?email=' + @michael.email
end

Cuando(/^accede a resetearla correctamente$/) do
  @michael.create_reset_digest
  @michael.save
  visit '/password_resets/' + @michael.reset_token + '/edit?email=' + @michael.email
end

Cuando(/^introduce los datos de reseteo incorrectamente$/) do
  fill_in 'user_password', with: 'sada'
  fill_in 'user_password_confirmation', with: 'scbnv'
  click_on 'Update password'
end

Cuando(/^introduce los datos de reseteo correctamente$/) do
  @password_anterior = @michael.password_digest
  fill_in 'user_password', with: 'foobar'
  fill_in 'user_password_confirmation', with: 'foobar'
  click_on 'Update password'
end

Cuando(/^accede a resetearla con el token incorrecto$/) do
  visit '/password_resets/token_incorrecto/edit?email=' + @michael.email
end

Cuando(/^no introduce la contraseña$/) do
  click_on 'Update password'
end

Entonces(/^se le notifica que el token ha expirado$/) do
  expect(page).to have_text 'expired'
end

Entonces(/^se le notifica que el correo es incorrecto$/) do
  expect(page).to have_text 'Email address not found'
end

Entonces(/^se le redirige a la página principal$/) do
  expect(current_path).to eq '/'
end

Entonces(/^se le muestra los errores$/) do
  expect(page).to have_css 'div#error_explanation'
end

Entonces(/^se le muestra un error$/) do
  expect(page).to have_text "can't be empty"
end

Entonces(/^se modifica la contraseña$/) do
  @michael.reload
  expect(@michael.reset_digest).to eq nil
  expect(@password_anterior).not_to eq @michael.password_digest
  expect(page).to have_text "Password has been reset."
  expect(current_path).to eq '/users/' + @michael.id
end