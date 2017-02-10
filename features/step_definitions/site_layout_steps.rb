Cuando(/^se accede a la página inicial$/) do
  visit '/'
end

Entonces(/^se debería ver la página inicial con un aspecto determinado$/) do
  expect(page).to have_link href: '/', count: 2
  expect(page).to have_link href: '/help'
  expect(page).to have_link href: '/about'
  expect(page).to have_link href: '/contact'
end

Cuando(/^se accede a la página de registro$/) do
  visit '/signup'
end

Entonces(/^se ve el título correctamente$/) do
  expect(page).to have_title full_title("Sign up")
end
