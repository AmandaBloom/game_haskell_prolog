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
        "I'm in hallwayGroundFloor. What a long corridor. For a long time \nMister Zero hasn't done cleaning here. What huge spiders are\nsitting on the ceiling\n"
        [oldChair,carKeys,doormat,pineDoor,oakDoor]
        [outside,room1]

    room1 :: Room
    room1 = Room "room1"
        "You are in the first room. Damn, the door to the next room is \nclosed. I have to find the key to the door to open the door to \nthe second room.\n"
        [wallClock,sofa,fridge,stove]
        [hallwayGroundFloor]

    room2 :: Room
    room2 = Room "room2"
        "It's so empty here, like after a robbery...\n"
        []
        [hallwayGroundFloor]

    corridor1Floor :: Room
    corridor1Floor = Room "corridor1Floor"
        "Hmm, what a fancy wardrobe is right in my path...\n"
        [wardrobe]
        [hallwayGroundFloor]

    room3 :: Room
    room3 = Room "room3"
        "All the wall a covered with acoustic boards in this room.\n"
        [carpet,musicStand,acousticGuitar,poster]
        [corridor1Floor,room4,room5]

    room4 :: Room
    room4 = Room "room4"
        "Small room. There was a work table and an armchair in the room,\nand a picture hung on the wall.\n"
        [picture,workTable,armchair]
        [room3]

    room5 :: Room
    room5 = Room "room5"
        "room5, it seems like it's his office!\n"
        [litterBox,cat,beanbagChair,scratchingPost]
        [room3]

