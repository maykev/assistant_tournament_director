#Admins
Admin.create!(email: "admin@mezzweststatetour.com", password: "mezzwest", super_admin: true)

#Levels
pro = Level.create!(name: "Pro", games_required: 9)
semi_pro = Level.create!(name: "Semi-Pro", games_required: 8)
open = Level.create!(name: "Open", games_required: 7)

#Players
Player.create!(first_name: "Kevin", last_name: "May", display_name: "Spartacus", level: open)
Player.create!(first_name: "Beau", last_name: "Runningen", display_name: "Beau R.", level: semi_pro)
Player.create!(first_name: "Oscar", last_name: "Dominguez", display_name: "Oscar", level: pro)