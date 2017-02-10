# Log in as a particular user.
def log_in_as(email = 'michael@example.com', password = 'password', remember_me = '1')
  visit '/login'
  fill_in 'session_email', with: email
  fill_in 'session_password', with: password
  if remember_me == 1 then check 'Remember me on this computer' end
  find('input[name="commit"]').click
end