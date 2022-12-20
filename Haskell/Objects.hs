module Objects where
    data Object = Object {
        name :: String,
        description :: String,
        actions :: String,
        isAt:: String,
        hasHidden :: [Object],
        isTakeable :: Bool,
        isLocked :: Bool,
        isMoved :: Bool,
        openWith :: Object
    } deriving (Show, Eq)

    nothing :: Object
    nothing = Object "nothing" "" "" "" [] False False False nothing

    carKeys :: Object
    carKeys = Object "carKeys"
        "Nice ... Besides being a villain, he also has a taste for cars. It''s like a code written at the belt - 1337. It may help me sometime. Car Alarm System pilot has 2 unlabeled buttons.\n"
        "I definitely shouldn''t use it. press left_button or press right_button\n"
        "hallwayGroundFloor" [] True False True nothing

    oldChair :: Object
    oldChair = Object "oldChair"
        "Looks like he likes old things, but he doesn''t take care of them. Very well...\n"
        ""
        "hallwayGroundFloor" [] True False True nothing

    oakDoor :: Object
    oakDoor = Object "oakDoor"
        "A Massive internal oakDoor.\n"
        "Shall i try opening it? - open\n"
        "hallwayGroundFloor" [] False True False nothing

    doormat :: Object
    doormat = Object "doormat"
        "Good old welcome doormat.\n"
        ""
        "hallwayGroundFloor" [] False False False nothing

    pineDoor :: Object
    pineDoor = Object "pineDoor"
        "A pineDoor with a big glass panel.\n"
        "Shall i try opening it? - open"
        "hallwayGroundFloor" [] False True False nothing

    fiberboardDoor :: Object
    fiberboardDoor = Object "fiberboardDoor"
        ""
        ""
        "hallwayGroundFloor" [] False True False nothing

    fridge :: Object
    fridge = Object "fridge"
        "Oooh, it''s time to update this old refrigerator. Buzzing like a plane on the runway.\n"
        ""
        "room1" [] False True False nothing

    sofa :: Object
    sofa = Object "sofa"
        "What an old shabby sofa. How can you sit on it?\n"
        ""
        "room1" [] False False False nothing

    wallClock :: Object
    wallClock = Object "wallClock"
        "It ain''t working from 1:37. Maybe its a sign???\n"
        ""
        "room1" [] True False False nothing

    stove :: Object
    stove = Object "stove"
        "White stove, surprisingly clean. Is rarely used.\n"
        ""
        "room1" [] True False False nothing

    wardrobe :: Object
    wardrobe = Object "wardrobe"
        "A large oak wardrobe closes the passage to the rooms on the 2nd floor.\n"
        ""
        "corridor1Floor" [] False True True nothing

    carpet :: Object
    carpet = Object "carpet"
        "Great modern carpet. The truth does not fit into the interior of the house a little, looks suspicious.\n"
        ""
        "room3" [] False False False nothing

    acousticGuitar :: Object
    acousticGuitar = Object "acousticGuitar"
        "Some strings are missings.\n"
        ""
        "room3" [] True False True nothing

    poster :: Object
    poster = Object "poster"
        "Metallica poster with a dark falcon on it.\n"
        ""
        "room3" [] True False True nothing

    musicStand :: Object
    musicStand = Object "musicStand"
        "Music stand with some sheets.\n"
        ""
        "room3" [] True False True nothing

    armchair :: Object
    armchair = Object "armchair"
        "A chair is like a chair. lol what else to say.\n"
        ""
        "room4" [] True False True nothing

    workTable :: Object
    workTable = Object "workTable"
        "It''s clear, mkay..\n"
        ""
        "room4" [] False False False nothing

    picture :: Object
    picture = Object "picture"
        "Is it a picture of a woman. I wonder who it is, on the back it is signed 'Jules 1978'.\n"
        ""
        "room4" [] True False True nothing

    safe :: Object
    safe = Object "safe"
        "You found a safe ! You need to enter a four-digit number. To open this safe .\n"
        ""
        "room4" [laptop] False True False code

    code :: Object
    code = Object "code" "1337" "" "" [] True False False nothing

    laptop :: Object
    laptop = Object "laptop"
        "Eeeee, I found! - take'\n"
        ""
        "room4" [] True False False nothing


    litterBox :: Object
    litterBox = Object "litterBox"
        "Blue litter box with sand. Fortunately with no wastes.\n"
        ""
        "room5" [] True False True nothing

    cat :: Object
    cat = Object "cat"
        "Black cat with white paws and belly. It still sleep even when I opened door.\n"
        ""
        "room5" [] False False False nothing

    beanbagChair :: Object
    beanbagChair = Object "beanbagChair"
        "Big beanbag chair full covered in cat hair.\n"
        ""
        "room5" [] False False False nothing

    scratchingPost :: Object
    scratchingPost = Object "scratchingPost"
        "Cat claw scratcher with hanging ball.\n"
        ""
        "room5" [] False False True nothing

    zincKey :: Object
    zincKey = Object "zincKey"
        "Zinc key.\n"
        ""
        "hallwayGroundFloor" [] False False True nothing

    getObjByName :: String -> Object
    getObjByName name = do
        case name of
            "carKeys" -> carKeys
            "oldChair" -> oldChair
            "oakDoor" -> oakDoor
            "doormat" -> doormat
            "pineDoor" -> pineDoor
            "fiberboardDoor" -> fiberboardDoor
            "fridge" -> fridge
            "sofa" -> sofa
            "wallClock" -> wallClock
            "stove" -> stove
            "wardrobe" -> wardrobe
            "carpet" -> carpet
            "acousticGuitar" -> acousticGuitar
            "poster" -> poster
            "musicStand" -> musicStand
            "armchair" -> armchair
            "workTable" -> workTable
            "picture" -> picture
            "safe" -> safe
            "laptop" -> laptop
            "litterBox" -> litterBox
            "cat" -> cat
            "beanbagChair" -> beanbagChair
            "scratchingPost" -> scratchingPost
