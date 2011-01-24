# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :notice do |notice|
  notice.association  :biblio
end

# This factory leads to a Type Mismatch error in tests
Factory.define :biblio do |biblio|
  biblio.title              "Main Notice title"
  biblio.description        "General resource description"
end
