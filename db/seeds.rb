# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email
Role.find_or_create_by!(name: 'admin')
Role.find_or_create_by!(name: 'event_orga')
Role.find_or_create_by!(name: 'circuit_orga')
Role.find_or_create_by!(name: 'trainer')
Role.find_or_create_by!(name: 'athlete')

# WIP
User.find_or_create_by!(email: 'admin@email.com') do |user|
  user.name = 'Admin'
  user.password = 'admin_password'
  user.password_confirmation = 'admin_password'
  user.update_attribute(:roles, user.roles.push(Role.find_by(name: 'admin')))
end

Sport.find_or_create_by!(name: 'French kick-boxing', description: "Because I love it.")
Sport.find_or_create_by!(name: 'Super Smash Bros. Ultimate', description: "Can be used for it too.")

simple_tournament = Event.find_or_create_by!(name: 'Simple tournament', description: 'Simple tournament used for tests.')
Event.find_or_create_by!(name: 'Event2', description: 'This is an event')

8.times do |i|
  user = User.find_or_create_by!(email: "athlete#{i}@test.com") do |user|
    user.name = "athlete#{i}"
    user.password = "athlete#{i}"
    user.password_confirmation = "athlete#{i}"
    user.update_attribute(:roles, user.roles.push(Role.find_by(name: 'athlete')))
  end

  simple_tournament.subscribe(user)
end
