require 'faker'

member = User.create!(name: "Member User", email: "member@example.com", password: "helloworld", email_confirmed: true)
member.save!  

premium = User.create!(name: "Premium User", email: "premium@example.com", password: "helloworld", email_confirmed: true, role: "premium")
premium.save!

admin = User.create!(name: "Admin", email: "admin@example.com", password: "helloworld", email_confirmed: true, role: "admin")
admin.save!
    
10.times do
  Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user_id: member.id, private: false)
end

5.times do
  Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user_id: premium.id, private: true)
end

puts "Seed Finished"
puts "#{Wiki.count} wikis created"
