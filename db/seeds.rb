require 'faker'

member = User.create!(name: "Member User", email: "member@example.com", password: "helloworld", email_confirmed: true)
member.save!   
    
10.times do
Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user_id: member.id)
end

puts "Seed Finished"
puts "#{Wiki.count} wikis created"
