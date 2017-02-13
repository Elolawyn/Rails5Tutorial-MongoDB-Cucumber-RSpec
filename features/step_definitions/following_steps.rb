Dado(/^dos usuarios michael y archer$/) do
  @michael = FactoryGirl.create(:michael)
  @archer = FactoryGirl.create(:archer)
end

Dado(/^ambos se siguen mutuamente$/) do
  @michael.follow(@archer)
  @archer.follow(@michael)
end

Cuando(/^michael accede a su lista de seguidores$/) do
  log_in_as(@michael.email, 'password', 1)
  visit '/users/' + @michael.id + '/followers'
end

Entonces(/^ve que lo sigue archer$/) do
  expect(@michael.followers.include?(@archer)).to eq true
  expect(page).to have_text @michael.followers.count.to_s
  @michael.followers.each do |user|
    expect(page).to have_link href: '/users/' + user.id
  end
end

Cuando(/^michael accede a su lista de personas que sigue$/) do
  log_in_as(@michael.email, 'password', 1)
  visit '/users/' + @michael.id + '/following'
end

Entonces(/^ve que sigue a archer$/) do
  expect(@michael.following.include?(@archer)).to eq true
  expect(page).to have_text @michael.following.count.to_s
  @michael.following.each do |user|
    expect(page).to have_link href: '/users/' + user.id
  end
end

Cuando(/^michael sigue a archer$/) do
  log_in_as(@michael.email, 'password', 1)
  visit '/users/' + @archer.id
  click_on 'Follow'
end

Entonces(/^la relación se establece$/) do
  @michael.reload
  @archer.reload
  expect(@michael.following.include?(@archer)).to eq true
end

Cuando(/^michael deja de seguir a archer$/) do
  @michael.follow(@archer)
  log_in_as(@michael.email, 'password', 1)
  visit '/users/' + @archer.id
  click_on 'Unfollow'
end

Entonces(/^la relación se rompe$/) do
  @michael.reload
  @archer.reload
  expect(@michael.following.include?(@archer)).to eq false
end