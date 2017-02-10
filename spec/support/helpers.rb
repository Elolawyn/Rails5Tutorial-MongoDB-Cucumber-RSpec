# Log in as a particular user.
def log_in_as(user)
  session[:user_id] = user.id
end