#Admins
Admin.where(email: "admin@mezzweststatetour.com").first_or_create!(password: "mezzwest", super_admin: true)

#Levels
pro = Level.where(name: "Pro").first_or_create!(games_required: 9)
semi_pro = Level.where(name: "Semi-Pro").first_or_create!(games_required: 8)
open = Level.where(name: "Open").first_or_create!(games_required: 7)

#Players
Player.where(first_name: "Kevin", last_name: "May").first_or_create!(display_name: "Kevin", level: open)
Player.where(first_name: "Beau", last_name: "Runningen").first_or_create!(display_name: "Beau", level: semi_pro)
Player.where(first_name: "Oscar", last_name: "Dominguez").first_or_create!(display_name: "Oscar", level: pro)
Player.where(first_name: "Ernesto", last_name: "Dominguez").first_or_create!(display_name: "Ernesto", level: pro)