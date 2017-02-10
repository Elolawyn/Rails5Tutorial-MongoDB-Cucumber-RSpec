Cuando(/^el usuario se logea, accede a su perfil y lo modifica erróneamente$/) do
  log_in_as(@michael.email, 'password', 1)
  visit('/users/' + @michael.id + '/edit')
  fill_in 'user_name', with: ""
  fill_in 'user_email', with: "foo@invalid"
  fill_in 'user_password', with: "foo"
  fill_in 'user_password_confirmation', with: "bar" 
  click_on 'Save changes' 
end

Entonces(/^su perfil no se actualiza y se muestran errores$/) do
  expect(page).to have_css 'div#error_explanation'
  expect(page).to have_css 'div.field_with_errors', count: 8
  expect(page).to have_text "Password confirmation doesn't match Password"
  expect(page).to have_text "Name can't be blank"
  expect(page).to have_text "Email is invalid"
  expect(page).to have_text "Password is too short (minimum is 6 characters)"
end

Cuando(/^el usuario se logea, accede a su perfil y lo modifica correctamente$/) do
  log_in_as(@michael.email, 'password', 1)
  visit('/users/' + @michael.id + '/edit')
  @name = "Foo Bar"
  @email = "foo@bar.com"
  fill_in 'user_name', with: @name
  fill_in 'user_email', with: @email
  fill_in 'user_password', with: ""
  fill_in 'user_password_confirmation', with: "" 
  click_on 'Save changes' 
end

Entonces(/^su perfil se actualiza$/) do
  expect(current_path).to eq '/users/' + @michael.id
  @michael.reload
  expect(@michael.name).to eq @name
  expect(@michael.email).to eq @email
end

Cuando(/^el usuario anónimo intenta acceder al perfil, es redirigido amistasamente y luego actualiza su perfil correctamente$/) do
  visit('/users/' + @michael.id + '/edit')
  expect(current_path).to eq '/login'
  log_in_as(@michael.email, 'password', 1)
  expect(current_path).to eq '/users/' + @michael.id + '/edit'
  @name = "Foo Bar"
  @email = "foo@bar.com"
  fill_in 'user_name', with: @name
  fill_in 'user_email', with: @email
  fill_in 'user_password', with: ""
  fill_in 'user_password_confirmation', with: "" 
  click_on 'Save changes' 
end
