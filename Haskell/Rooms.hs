module Rooms where
    import Objects
    data Room = Room {
        name :: String,
        description :: String,
        has :: [Object],
        passage :: [Room]
    } deriving (Show, Eq)

    nothing :: Room
    nothing = Room "" "" [] []

    hallway_ground_floor :: Room
    hallway_ground_floor = Room "hallway_ground_floor"
        "I''m in hallway_ground_floor What a long corridor. For a long time Mister Zero hasn''t done cleaning here. What huge spiders are sitting on the ceiling"
        [old_chair,car_keys,doormat,pine_door,oak_door,fiberboard_door]
        [room1,room2,corridor_1_floor]

    room1 :: Room
    room1 = Room "room1"
        "You are in the first room. Damn, the door to the next room is closed. I have to find the key to the door to open the door to the second room."
        [wall_clock,sofa,fridge,stove]
        [hallway_ground_floor]

    room2 :: Room
    room2 = Room "room2"
        "It''s so empty here, like after a robbery"
        []
        [hallway_ground_floor]

    corridor_1_floor :: Room
    corridor_1_floor = Room "corridor_1_floor"
        "Hmm, what a fancy wardrobe is right in my path."
        [wardrobe]
        [hallway_ground_floor,room3,room4,room5]

    room3 :: Room
    room3 = Room "room3"
        "All the wall a covered with acoustic boards in this room."
        [carpet,music_stand,acoustic_guitar,poster]
        [corridor_1_floor]

    room4 :: Room
    room4 = Room "room4"
        "Small room. There was a work table and an armchair in the room, and a picture hung on the wall."
        [picture,work_table,armchair]
        [corridor_1_floor]

    room5 :: Room
    room5 = Room "room5"
        "room5, it seems like it''s his office"
        [litter_box,cat,beanbag_chair,scratching_post]
        [corridor_1_floor]

    getRoomByName :: String -> Room
    getRoomByName name = case name of
        "hallway_ground_floor" -> hallway_ground_floor
        "corridor_1_floor" -> corridor_1_floor
        "room1" -> room1
        "room2" -> room2
        "room3" -> room3
        "room4" -> room4
        "room5" -> room5
        _ -> Rooms.nothing
