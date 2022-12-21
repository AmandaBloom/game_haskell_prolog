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

    outside :: Room
    outside = Room "outside" "" [] []

    hallwayGroundFloor :: Room
    hallwayGroundFloor = Room "hallwayGroundFloor"
        "I''m in hallwayGroundFloor. What a long corridor. For a long time Mister Zero hasn''t done cleaning here. What huge spiders are sitting on the ceiling"
        [oldChair,carKeys,doormat,pineDoor,oakDoor,fiberboardDoor]
        [outside,room1]

    room1 :: Room
    room1 = Room "room1"
        "You are in the first room. Damn, the door to the next room is closed. I have to find the key to the door to open the door to the second room."
        [wallClock,sofa,fridge,stove]
        [hallwayGroundFloor]

    room2 :: Room
    room2 = Room "room2"
        "It''s so empty here, like after a robbery"
        []
        [hallwayGroundFloor]

    corridor1Floor :: Room
    corridor1Floor = Room "corridor1Floor"
        "Hmm, what a fancy wardrobe is right in my path."
        [wardrobe]
        [hallwayGroundFloor,room3,room4,room5]

    room3 :: Room
    room3 = Room "room3"
        "All the wall a covered with acoustic boards in this room."
        [carpet,musicStand,acousticGuitar,poster]
        [corridor1Floor]

    room4 :: Room
    room4 = Room "room4"
        "Small room. There was a work table and an armchair in the room, and a picture hung on the wall."
        [picture,workTable,armchair]
        [corridor1Floor]

    room5 :: Room
    room5 = Room "room5"
        "room5, it seems like it''s his office"
        [litterBox,cat,beanbagChair,scratchingPost]
        [corridor1Floor]

