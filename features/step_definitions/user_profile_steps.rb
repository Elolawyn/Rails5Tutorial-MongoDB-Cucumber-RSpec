Cuando(/^accede a su página de perfil$/) do
  log_in_as(@michael.email, 'password', 1)
  visit '/users/' + @michael.id
end

Entonces(/^recibe su página con el aspecto adecuado$/) do
  expect(page).to have_title full_title(@michael.name)
  expect(page).to have_text @michael.name
  expect(page).to have_css 'h1>img.gravatar'
  expect(page).to have_text "Microposts (" + @michael.microposts.count.to_s + ")"
  expect(page).to have_css 'div.pagination'
  @michael.microposts.paginate(page: 1).each do |micropost|
    expect(page).to have_text micropost.content
  end
end