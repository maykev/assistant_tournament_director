# Admins
Admin.where(email: "admin@mezzweststatetour.com").update_all(encrypted_password: "$2a$10$wngKVN9TkaUBWiLAQK/FHeZZiKUOvcSgu5mdOWFSjAgZXCTvHLNOy", super_admin: true)

# Levels
pro = Level.where(name: "Pro").first_or_create!(games_required: 9)
semi_pro = Level.where(name: "Semi-Pro").first_or_create!(games_required: 8)
open = Level.where(name: "Open").first_or_create!(games_required: 7)

# Bracket Configurations
BracketConfiguration.where(size: 32).first_or_create(
    bye_pattern: [32, 16, 24, 8, 28, 12, 20, 4, 30, 14, 22, 6, 26, 10, 18, 2],
    loser_pattern: [
        "W1-M1->L2-M1",
        "W1-M2->L2-M1",
        "W1-M3->L2-M2",
        "W1-M4->L2-M2",
        "W1-M5->L2-M3",
        "W1-M6->L2-M3",
        "W1-M7->L2-M4",
        "W1-M8->L2-M4",
        "W1-M9->L2-M5",
        "W1-M10->L2-M5",
        "W1-M11->L2-M6",
        "W1-M12->L2-M6",
        "W1-M13->L2-M7",
        "W1-M14->L2-M7",
        "W1-M15->L2-M8",
        "W1-M16->L2-M8",
        "W2-M1->L3-M8",
        "W2-M2->L3-M7",
        "W2-M3->L3-M6",
        "W2-M4->L3-M5",
        "W2-M5->L3-M4",
        "W2-M6->L3-M3",
        "W2-M7->L3-M2",
        "W2-M8->L3-M1",
        "W3-M1->L5-M2",
        "W3-M2->L5-M1",
        "W3-M3->L5-M4",
        "W3-M4->L5-M3",
        "W4-M1->L7-M2",
        "W4-M2->L7-M1",
        "W5-M1->L9-M1",
        "L9-M1->W6-M1"
    ]
)

BracketConfiguration.where(size: 64).first_or_create(
    bye_pattern: [64, 32, 48, 16, 56, 24, 40, 8, 60, 28, 44, 12, 52, 20, 36,
        4, 62, 30, 46, 14, 54, 22, 38, 6, 58, 26, 42, 10, 50, 18, 34, 2],
    loser_pattern: [
        "W1-M1->L2-M1",
        "W1-M2->L2-M1",
        "W1-M3->L2-M2",
        "W1-M4->L2-M2",
        "W1-M5->L2-M3",
        "W1-M6->L2-M3",
        "W1-M7->L2-M4",
        "W1-M8->L2-M4",
        "W1-M9->L2-M5",
        "W1-M10->L2-M5",
        "W1-M11->L2-M6",
        "W1-M12->L2-M6",
        "W1-M13->L2-M7",
        "W1-M14->L2-M7",
        "W1-M15->L2-M8",
        "W1-M16->L2-M8",
        "W1-M17->L2-M9",
        "W1-M18->L2-M9",
        "W1-M19->L2-M10",
        "W1-M20->L2-M10",
        "W1-M21->L2-M11",
        "W1-M22->L2-M11",
        "W1-M23->L2-M12",
        "W1-M24->L2-M12",
        "W1-M25->L2-M13",
        "W1-M26->L2-M13",
        "W1-M27->L2-M14",
        "W1-M28->L2-M14",
        "W1-M29->L2-M15",
        "W1-M30->L2-M15",
        "W1-M31->L2-M16",
        "W1-M32->L2-M16",
        "W2-M1->L3-M8",
        "W2-M2->L3-M7",
        "W2-M3->L3-M6",
        "W2-M4->L3-M5",
        "W2-M5->L3-M4",
        "W2-M6->L3-M3",
        "W2-M7->L3-M2",
        "W2-M8->L3-M1",
        "W3-M1->L5-M2",
        "W3-M2->L5-M1",
        "W3-M3->L5-M4",
        "W3-M4->L5-M3",
        "W4-M1->L7-M2",
        "W4-M2->L7-M1",
        "W5-M1->L9-M1",
        "L9-M1->W6-M1"
    ]
)

BracketConfiguration.where(size: 128).first_or_create(
    bye_pattern: [128, 64, 96, 32, 112, 48, 80, 16, 120, 56, 88, 24, 104, 40, 72, 8, 124, 60, 92, 28, 108, 44, 76,
        12, 116, 52, 84, 20, 100, 36, 68, 4, 126, 62, 94, 30, 110, 46, 78, 14, 118, 54, 86, 22, 102, 38, 70, 6,
        122, 58, 90, 26, 106, 42, 74, 10, 114, 50, 82, 18, 98, 34, 66, 2],
    loser_pattern: [
        "W1-M1->L2-M1",
        "W1-M2->L2-M1",
        "W1-M3->L2-M2",
        "W1-M4->L2-M2",
        "W1-M5->L2-M3",
        "W1-M6->L2-M3",
        "W1-M7->L2-M4",
        "W1-M8->L2-M4",
        "W1-M9->L2-M5",
        "W1-M10->L2-M5",
        "W1-M11->L2-M6",
        "W1-M12->L2-M6",
        "W1-M13->L2-M7",
        "W1-M14->L2-M7",
        "W1-M15->L2-M8",
        "W1-M16->L2-M8",
        "W1-M17->L2-M9",
        "W1-M18->L2-M9",
        "W1-M19->L2-M10",
        "W1-M20->L2-M10",
        "W1-M21->L2-M11",
        "W1-M22->L2-M11",
        "W1-M23->L2-M12",
        "W1-M24->L2-M12",
        "W1-M25->L2-M13",
        "W1-M26->L2-M13",
        "W1-M27->L2-M14",
        "W1-M28->L2-M14",
        "W1-M29->L2-M15",
        "W1-M30->L2-M15",
        "W1-M31->L2-M16",
        "W1-M32->L2-M16",
        "W1-M33->L2-M17",
        "W1-M34->L2-M17",
        "W1-M35->L2-M18",
        "W1-M36->L2-M18",
        "W1-M37->L2-M19",
        "W1-M38->L2-M19",
        "W1-M39->L2-M20",
        "W1-M40->L2-M20",
        "W1-M41->L2-M21",
        "W1-M42->L2-M21",
        "W1-M43->L2-M22",
        "W1-M44->L2-M22",
        "W1-M45->L2-M23",
        "W1-M46->L2-M23",
        "W1-M47->L2-M24",
        "W1-M48->L2-M24",
        "W1-M49->L2-M25",
        "W1-M50->L2-M25",
        "W1-M51->L2-M26",
        "W1-M52->L2-M26",
        "W1-M53->L2-M27",
        "W1-M54->L2-M27",
        "W1-M55->L2-M28",
        "W1-M56->L2-M28",
        "W1-M57->L2-M29",
        "W1-M58->L2-M29",
        "W1-M59->L2-M30",
        "W1-M60->L2-M30",
        "W1-M61->L2-M31",
        "W1-M62->L2-M31",
        "W1-M63->L2-M32",
        "W1-M64->L2-M32",
        "W2-M1->L3-M32",
        "W2-M2->L3-M31",
        "W2-M3->L3-M30",
        "W2-M4->L3-M29",
        "W2-M5->L3-M28",
        "W2-M6->L3-M27",
        "W2-M7->L3-M26",
        "W2-M8->L3-M25",
        "W2-M9->L3-M24",
        "W2-M10->L3-M23",
        "W2-M11->L3-M22",
        "W2-M12->L3-M21",
        "W2-M13->L3-M20",
        "W2-M14->L3-M19",
        "W2-M15->L3-M18",
        "W2-M16->L3-M17",
        "W2-M17->L3-M16",
        "W2-M18->L3-M15",
        "W2-M19->L3-M14",
        "W2-M20->L3-M13",
        "W2-M21->L3-M12",
        "W2-M22->L3-M11",
        "W2-M23->L3-M10",
        "W2-M24->L3-M9",
        "W2-M25->L3-M8",
        "W2-M26->L3-M7",
        "W2-M27->L3-M6",
        "W2-M28->L3-M5",
        "W2-M29->L3-M4",
        "W2-M30->L3-M3",
        "W2-M31->L3-M2",
        "W2-M32->L3-M1",
        "W3-M1->L5-M8",
        "W3-M2->L5-M7",
        "W3-M3->L5-M6",
        "W3-M4->L5-M5",
        "W3-M5->L5-M4",
        "W3-M6->L5-M3",
        "W3-M7->L5-M2",
        "W3-M8->L5-M1",
        "W3-M9->L5-M16",
        "W3-M10->L5-M15",
        "W3-M11->L5-M14",
        "W3-M12->L5-M13",
        "W3-M13->L5-M12",
        "W3-M14->L5-M11",
        "W3-M15->L5-M10",
        "W3-M16->L5-M9",
        "W4-M1->L7-M5",
        "W4-M2->L7-M6",
        "W4-M3->L7-M7",
        "W4-M4->L7-M8",
        "W4-M5->L7-M1",
        "W4-M6->L7-M2",
        "W4-M7->L7-M3",
        "W4-M8->L7-M4",
        "W5-M1->L9-M1",
        "W5-M2->L9-M2",
        "W5-M3->L9-M3",
        "W5-M4->L9-M4",
        "W6-M1->L11-M2",
        "W6-M2->L11-M1",
        "W7-M1->L13-M1",
        "L13-M1->W8-M1"
    ]
)

# Players
Player.where(first_name: "Aldrin", last_name: "Germiniano").first_or_create!(level: open)
Player.where(first_name: "Alex", last_name: "Aguiar").first_or_create!(level: open)
Player.where(first_name: "Alfred", last_name: "Martinez").first_or_create!(level: open)
Player.where(first_name: "Amar", last_name: "Kang").first_or_create!(level: pro)
Player.where(first_name: "Andrew", last_name: "Park").first_or_create!(level: open)
Player.where(first_name: "Anthony", last_name: "Ortega").first_or_create!(level: open)
Player.where(first_name: "Art", last_name: "Garcia").first_or_create!(level: open)
Player.where(first_name: "Arturo", last_name: "Rivera").first_or_create!(level: semi_pro)
Player.where(first_name: "Attila", last_name: "Bezdan").first_or_create!(level: pro)
Player.where(first_name: "Attila", last_name: "Csorba").first_or_create!(level: open)
Player.where(first_name: "Babken", last_name: "Melkonyan").first_or_create!(level: semi_pro)
Player.where(first_name: "Barbara", last_name: "Lee").first_or_create!(level: open)
Player.where(first_name: "Bart", last_name: "Mahoney").first_or_create!(level: semi_pro)
Player.where(first_name: "Beau", last_name: "Runningen").first_or_create!(level: pro)
Player.where(first_name: "Bee", last_name: "Davidson").first_or_create!(level: open)
Player.where(first_name: "Ben", last_name: "Black").first_or_create!(level: open)
Player.where(first_name: "Bill", last_name: "Norrish").first_or_create!(level: open)
Player.where(first_name: "Bill", last_name: "Villareal").first_or_create!(level: open)
Player.where(first_name: "Billy", last_name: "Pence").first_or_create!(level: open)
Player.where(first_name: "Billy", last_name: "Silviera").first_or_create!(level: open)
Player.where(first_name: "Bob", last_name: "DePlachett").first_or_create!(level: open)
Player.where(first_name: "Bob", last_name: "Jocz").first_or_create!(level: open)
Player.where(first_name: "Bobby", last_name: "Lees").first_or_create!(level: open)
Player.where(first_name: "Branch", last_name: "Talley").first_or_create!(level: open)
Player.where(first_name: "Brian", last_name: "Elwell").first_or_create!(level: open)
Player.where(first_name: "Brian", last_name: "Law").first_or_create!(level: open)
Player.where(first_name: "Brian", last_name: "Parks").first_or_create!(level: semi_pro)
Player.where(first_name: "Brook", last_name: "Thomason").first_or_create!(level: open)
Player.where(first_name: "Butch", last_name: "Barbra").first_or_create!(level: open)
Player.where(first_name: "Carl", last_name: "Wilson").first_or_create!(level: semi_pro)
Player.where(first_name: "Carlos", last_name: "Mendoza").first_or_create!(level: open)
Player.where(first_name: "Chad", last_name: "Barber").first_or_create!(level: open)
Player.where(first_name: "Charles", last_name: "Mendiola").first_or_create!(level: open)
Player.where(first_name: "Chris", last_name: "Atkins").first_or_create!(level: open)
Player.where(first_name: "Chris", last_name: "Fangre").first_or_create!(level: semi_pro)
Player.where(first_name: "Chris", last_name: "Robinson").first_or_create!(level: open)
Player.where(first_name: "Chris", last_name: "Wedekin").first_or_create!(level: open)
Player.where(first_name: "Christy", last_name: "Lipps").first_or_create!(level: open)
Player.where(first_name: "CJ", last_name: "Robinson").first_or_create!(level: open)
Player.where(first_name: "Clint", last_name: "Palaci").first_or_create!(level: open)
Player.where(first_name: "Dale", last_name: "Kadouhl").first_or_create!(level: open)
Player.where(first_name: "Damian", last_name: "Rebman").first_or_create!(level: open)
Player.where(first_name: "Dan", last_name: "Russo").first_or_create!(level: open)
Player.where(first_name: "Dan", last_name: "Wallace").first_or_create!(level: semi_pro)
Player.where(first_name: "Dane", last_name: "Elmsteadt").first_or_create!(level: open)
Player.where(first_name: "Daniel", last_name: "Aguiar").first_or_create!(level: open)
Player.where(first_name: "Danny", last_name: "Gokhul").first_or_create!(level: pro)
Player.where(first_name: "Darryl", last_name: "Taylor").first_or_create!(level: open)
Player.where(first_name: "Dave", last_name: "Espinoza").first_or_create!(level: open)
Player.where(first_name: "Dave", last_name: "Gorham").first_or_create!(level: open)
Player.where(first_name: "Dave", last_name: "Hemmah").first_or_create!(level: semi_pro)
Player.where(first_name: "Dave", last_name: "Vincent").first_or_create!(level: open)
Player.where(first_name: "David", last_name: "Delcastillo").first_or_create!(level: open)
Player.where(first_name: "David", last_name: "Gomez").first_or_create!(level: open)
Player.where(first_name: "David", last_name: "Martineau").first_or_create!(level: open)
Player.where(first_name: "Delbert", last_name: "Wong").first_or_create!(level: open)
Player.where(first_name: "Deo", last_name: "Alpojara").first_or_create!(level: semi_pro)
Player.where(first_name: "Derek", last_name: "Kiim").first_or_create!(level: open)
Player.where(first_name: "Don", last_name: "Davies").first_or_create!(level: open)
Player.where(first_name: "Ed", last_name: "Gonzeles").first_or_create!(level: open)
Player.where(first_name: "Ed", last_name: "Marshton").first_or_create!(level: open)
Player.where(first_name: "Ed", last_name: "Ramos").first_or_create!(level: open)
Player.where(first_name: "Ed", last_name: "Sellers").first_or_create!(level: open)
Player.where(first_name: "Eddie", last_name: "Cohen").first_or_create!(level: open)
Player.where(first_name: "Edwin", last_name: "Urbano").first_or_create!(level: open)
Player.where(first_name: "Efren", last_name: "Reyes").first_or_create!(level: pro)
Player.where(first_name: "Emerson", last_name: "Joiner").first_or_create!(level: open)
Player.where(first_name: "Eric", last_name: "Harada").first_or_create!(level: open)
Player.where(first_name: "Eric", last_name: "Scott").first_or_create!(level: open)
Player.where(first_name: "Eric", last_name: "Stanley").first_or_create!(level: open)
Player.where(first_name: "Ernesto", last_name: "Dominguez").first_or_create!(level: pro)
Player.where(first_name: "Fach", last_name: "Garcia").first_or_create!(level: semi_pro)
Player.where(first_name: "Francis", last_name: "Ritarita").first_or_create!(level: open)
Player.where(first_name: "Frank", last_name: "Almanza").first_or_create!(level: open)
Player.where(first_name: "Frank", last_name: "Giordano").first_or_create!(level: open)
Player.where(first_name: "Frank", last_name: "Robutz").first_or_create!(level: open)
Player.where(first_name: "Fransico", last_name: "Bustamante").first_or_create!(level: pro)
Player.where(first_name: "George", last_name: "Pagulayan").first_or_create!(level: open)
Player.where(first_name: "Glenn", last_name: "Umemoto").first_or_create!(level: open)
Player.where(first_name: "Greg", last_name: "Harada").first_or_create!(level: semi_pro)
Player.where(first_name: "Greg", last_name: "Veach").first_or_create!(level: open)
Player.where(first_name: "Hiroko", last_name: "Makiyama").first_or_create!(level: open)
Player.where(first_name: "Horia", last_name: "Udrea").first_or_create!(level: open)
Player.where(first_name: "Howard", last_name: "Kennedy").first_or_create!(level: open)
Player.where(first_name: "Jack", last_name: "Ritonya").first_or_create!(level: open)
Player.where(first_name: "Jaden", last_name: "Brock").first_or_create!(level: open)
Player.where(first_name: "James", last_name: "Harris").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Batin").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Carandang").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Ferroni").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Gilbert").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Hardcastle").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Katon").first_or_create!(level: open)
Player.where(first_name: "Jason", last_name: "Williams").first_or_create!(level: semi_pro)
Player.where(first_name: "Javier", last_name: "Ramirez").first_or_create!(level: open)
Player.where(first_name: "Jay", last_name: "Helfert").first_or_create!(level: open)
Player.where(first_name: "Jay", last_name: "Mulibayan").first_or_create!(level: open)
Player.where(first_name: "Jay", last_name: "Pee").first_or_create!(level: open)
Player.where(first_name: "Jaynard", last_name: "Orque").first_or_create!(level: semi_pro)
Player.where(first_name: "Jeff", last_name: "Gregory").first_or_create!(level: semi_pro)
Player.where(first_name: "Jenny", last_name: "Lee").first_or_create!(level: open)
Player.where(first_name: "Jerry", last_name: "Jamito").first_or_create!(level: pro)
Player.where(first_name: "Jerry", last_name: "Lin").first_or_create!(level: semi_pro)
Player.where(first_name: "Jerry", last_name: "Stuckart").first_or_create!(level: open)
Player.where(first_name: "Jim", last_name: "Burt").first_or_create!(level: open)
Player.where(first_name: "Jim", last_name: "Hennessy").first_or_create!(level: open)
Player.where(first_name: "Jimmy", last_name: "Qu").first_or_create!(level: open)
Player.where(first_name: "Joe", last_name: "Delio").first_or_create!(level: open)
Player.where(first_name: "Joe", last_name: "Stein").first_or_create!(level: open)
Player.where(first_name: "Joe", last_name: "Chin").first_or_create!(level: open)
Player.where(first_name: "John", last_name: "Barioni").first_or_create!(level: open)
Player.where(first_name: "John", last_name: "Fergeson").first_or_create!(level: open)
Player.where(first_name: "John", last_name: "Nekali").first_or_create!(level: open)
Player.where(first_name: "John", last_name: "Ritonya").first_or_create!(level: open)
Player.where(first_name: "John", last_name: "Schmidt").first_or_create!(level: pro)
Player.where(first_name: "JohnMark", last_name: "Hernandez").first_or_create!(level: open)
Player.where(first_name: "Johnny", last_name: "Kang").first_or_create!(level: pro)
Player.where(first_name: "Josh", last_name: "Gomes").first_or_create!(level: open)
Player.where(first_name: "Juan", last_name: "Ortega").first_or_create!(level: open)
Player.where(first_name: "Junne", last_name: "Padua").first_or_create!(level: open)
Player.where(first_name: "Justin", last_name: "Logan").first_or_create!(level: open)
Player.where(first_name: "Justin", last_name: "Marks").first_or_create!(level: open)
Player.where(first_name: "Keith", last_name: "O'Donnel").first_or_create!(level: open)
Player.where(first_name: "Keith", last_name: "Valet").first_or_create!(level: open)
Player.where(first_name: "Ken", last_name: "Chang").first_or_create!(level: open)
Player.where(first_name: "Ken", last_name: "Gouso").first_or_create!(level: open)
Player.where(first_name: "Ken", last_name: "Johnson").first_or_create!(level: open)
Player.where(first_name: "Ken", last_name: "Mendoza").first_or_create!(level: open)
Player.where(first_name: "Ken", last_name: "Thomason").first_or_create!(level: open)
Player.where(first_name: "Kenny", last_name: "Ash").first_or_create!(level: open)
Player.where(first_name: "Kenny", last_name: "Koo").first_or_create!(level: open)
Player.where(first_name: "Kevin", last_name: "Collins").first_or_create!(level: open)
Player.where(first_name: "Kevin", last_name: "Knucky").first_or_create!(level: open)
Player.where(first_name: "Kevin", last_name: "May").first_or_create!(level: open)
Player.where(first_name: "KID", last_name: "").first_or_create!(level: open)
Player.where(first_name: "Kirk", last_name: "Jewel").first_or_create!(level: open)
Player.where(first_name: "Kristina", last_name: "Cordova").first_or_create!(level: open)
Player.where(first_name: "Lance", last_name: "Johnson").first_or_create!(level: open)
Player.where(first_name: "Larry", last_name: "Bohn").first_or_create!(level: open)
Player.where(first_name: "Lee", last_name: "Silkwood").first_or_create!(level: open)
Player.where(first_name: "Lenny", last_name: "Brock").first_or_create!(level: open)
Player.where(first_name: "Loren", last_name: "Mah").first_or_create!(level: open)
Player.where(first_name: "Lori", last_name: "Jones").first_or_create!(level: open)
Player.where(first_name: "Lorry", last_name: "Deleon").first_or_create!(level: semi_pro)
Player.where(first_name: "Luke", last_name: "Mahan").first_or_create!(level: open)
Player.where(first_name: "Manual", last_name: "Herrera").first_or_create!(level: open)
Player.where(first_name: "Marcelino", last_name: "Montoya").first_or_create!(level: open)
Player.where(first_name: "Mark", last_name: "Tiu").first_or_create!(level: open)
Player.where(first_name: "Mark", last_name: "Whitehead").first_or_create!(level: open)
Player.where(first_name: "Marty", last_name: "Carey").first_or_create!(level: open)
Player.where(first_name: "MaryAnn", last_name: "Starkey").first_or_create!(level: open)
Player.where(first_name: "Melinda", last_name: "Huang").first_or_create!(level: open)
Player.where(first_name: "Melissa", last_name: "Herndon").first_or_create!(level: open)
Player.where(first_name: "Michael", last_name: "Campos").first_or_create!(level: open)
Player.where(first_name: "Michael", last_name: "Glass").first_or_create!(level: open)
Player.where(first_name: "Mike", last_name: "Langarica").first_or_create!(level: open)
Player.where(first_name: "Mike", last_name: "Laos").first_or_create!(level: open)
Player.where(first_name: "Mike", last_name: "Meeker").first_or_create!(level: open)
Player.where(first_name: "Minnie", last_name: "Tayaotao").first_or_create!(level: open)
Player.where(first_name: "Morro", last_name: "Paez").first_or_create!(level: semi_pro)
Player.where(first_name: "Nate", last_name: "Stipek").first_or_create!(level: open)
Player.where(first_name: "Nick", last_name: "Callado").first_or_create!(level: open)
Player.where(first_name: "Nick", last_name: "Spano").first_or_create!(level: semi_pro)
Player.where(first_name: "Nico", last_name: "Scalise").first_or_create!(level: open)
Player.where(first_name: "Omar", last_name: "Vachhani").first_or_create!(level: open)
Player.where(first_name: "Oscar", last_name: "Dominguez").first_or_create!(level: pro)
Player.where(first_name: "Paul", last_name: "Ewing").first_or_create!(level: open)
Player.where(first_name: "Paul", last_name: "Higaki").first_or_create!(level: open)
Player.where(first_name: "Paul", last_name: "Santos").first_or_create!(level: open)
Player.where(first_name: "Paul", last_name: "Silva").first_or_create!(level: open)
Player.where(first_name: "Peter", last_name: "Leung").first_or_create!(level: open)
Player.where(first_name: "Phil", last_name: "Prentice").first_or_create!(level: open)
Player.where(first_name: "Ramin", last_name: "Bakhtiari").first_or_create!(level: semi_pro)
Player.where(first_name: "Ramon", last_name: "Mistica").first_or_create!(level: pro)
Player.where(first_name: "Randy", last_name: "Hatten").first_or_create!(level: open)
Player.where(first_name: "Ray", last_name: "Moran").first_or_create!(level: open)
Player.where(first_name: "Ray", last_name: "Pajarillo").first_or_create!(level: open)
Player.where(first_name: "Ray", last_name: "Rey").first_or_create!(level: open)
Player.where(first_name: "Ray", last_name: "Robles").first_or_create!(level: open)
Player.where(first_name: "Reid", last_name: "Flemining").first_or_create!(level: open)
Player.where(first_name: "Reid", last_name: "Strensrud").first_or_create!(level: open)
Player.where(first_name: "Rex", last_name: "Chan").first_or_create!(level: open)
Player.where(first_name: "Rich", last_name: "Hodge").first_or_create!(level: open)
Player.where(first_name: "Richard", last_name: "Daniel").first_or_create!(level: open)
Player.where(first_name: "Rob", last_name: "Eggers").first_or_create!(level: open)
Player.where(first_name: "Robbie", last_name: "Ling").first_or_create!(level: open)
Player.where(first_name: "Robert", last_name: "Laurie").first_or_create!(level: open)
Player.where(first_name: "Rodney", last_name: "Morris").first_or_create!(level: pro)
Player.where(first_name: "Rodney", last_name: "Wynn").first_or_create!(level: open)
Player.where(first_name: "Rodrigo", last_name: "Geronimo").first_or_create!(level: pro)
Player.where(first_name: "Ron", last_name: "Riesler").first_or_create!(level: open)
Player.where(first_name: "Ruben", last_name: "Bautista").first_or_create!(level: pro)
Player.where(first_name: "Rudy", last_name: "Dominguez").first_or_create!(level: open)
Player.where(first_name: "Rudy", last_name: "Estoque").first_or_create!(level: open)
Player.where(first_name: "Rudy", last_name: "Torres").first_or_create!(level: open)
Player.where(first_name: "Ryan", last_name: "Laws").first_or_create!(level: open)
Player.where(first_name: "Rylan", last_name: "Hartnett").first_or_create!(level: open)
Player.where(first_name: "Sajal", last_name: "Ghamire").first_or_create!(level: open)
Player.where(first_name: "Santos", last_name: "Sambjon").first_or_create!(level: pro)
Player.where(first_name: "Scott", last_name: "Slayton").first_or_create!(level: open)
Player.where(first_name: "Shan", last_name: "Damani").first_or_create!(level: open)
Player.where(first_name: "Shawn", last_name: "Polk").first_or_create!(level: open)
Player.where(first_name: "Stacy", last_name: "Novak").first_or_create!(level: open)
Player.where(first_name: "Stanton", last_name: "Oda").first_or_create!(level: open)
Player.where(first_name: "Stephanie", last_name: "Hefner").first_or_create!(level: open)
Player.where(first_name: "Stephano", last_name: "Lopez").first_or_create!(level: open)
Player.where(first_name: "Stephen", last_name: "Poma").first_or_create!(level: open)
Player.where(first_name: "Steve", last_name: "Chaplin").first_or_create!(level: open)
Player.where(first_name: "Steve", last_name: "Mansfield").first_or_create!(level: open)
Player.where(first_name: "Sy", last_name: "Nakashima").first_or_create!(level: semi_pro)
Player.where(first_name: "Tang", last_name: "Hoa").first_or_create!(level: semi_pro)
Player.where(first_name: "Teresa", last_name: "Mojica").first_or_create!(level: open)
Player.where(first_name: "Tim", last_name: "Daniel").first_or_create!(level: open)
Player.where(first_name: "Tina", last_name: "Hess").first_or_create!(level: open)
Player.where(first_name: "Tom", last_name: "Hardinger").first_or_create!(level: open)
Player.where(first_name: "Tom", last_name: "Smith").first_or_create!(level: open)
Player.where(first_name: "Tommy", last_name: "Lipps").first_or_create!(level: open)
Player.where(first_name: "Tony", last_name: "Rodiguez").first_or_create!(level: open)
Player.where(first_name: "Tres", last_name: "Kane").first_or_create!(level: open)
Player.where(first_name: "Trinh", last_name: "Lu").first_or_create!(level: open)
Player.where(first_name: "Tyler", last_name: "Van Wulven").first_or_create!(level: open)
Player.where(first_name: "Vicki", last_name: "Wade").first_or_create!(level: open)
Player.where(first_name: "Victor", last_name: "Ignacio").first_or_create!(level: semi_pro)
Player.where(first_name: "Victor", last_name: "Valseca").first_or_create!(level: open)
Player.where(first_name: "Vilmos", last_name: "Foldes").first_or_create!(level: pro)
Player.where(first_name: "Wayne", last_name: "Larson").first_or_create!(level: open)
Player.where(first_name: "Wei", last_name: "Ni").first_or_create!(level: open)
Player.where(first_name: "Yoli", last_name: "Hakanado").first_or_create!(level: open)
Player.where(first_name: "Yvonne", last_name: "Asher").first_or_create!(level: open)
Player.where(first_name: "Zeke", last_name: "Morrison").first_or_create!(level: semi_pro)
