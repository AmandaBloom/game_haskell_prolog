module Objects where
    data Object = Object {
        name :: String,
        description :: String,
        actions :: String,
        isAt:: String,
        hasHidden :: [Object],
        isTakeable :: Bool,
        isLocked :: Bool,
        openWith :: Object
    } deriving (Show, Eq)

    nothing :: Object
    nothing = Object "nothing" "" "" "" [] False False nothing

    car_keys :: Object
    car_keys = Object "car keys"
        "Nice ... Besides being a villain, he also has a taste for cars. It''s like a code written at the belt - 1337. It may help me sometime. Car Alarm System pilot has 2 unlabeled buttons.\n"
        "I definitely shouldn''t use it. press left_button or press right_button\n"
        "hallway_ground_floor" [] True False nothing

    old_chair :: Object
    old_chair = Object "old chair"
        "Looks like he likes old things, but he doesn''t take care of them. Very well...\n"
        ""
        "hallway_ground_floor" [] True False nothing

    oak_door :: Object
    oak_door = Object "oak door"
        "A Massive internal oak door.\n"
        "Shall i try opening it? - open\n"
        "hallway_ground_floor" [] False True nothing
   
    doormat :: Object
    doormat = Object "doormat"
        "Good old welcome doormat.\n"
        ""
        "hallway_ground_floor" [] False False nothing

    pine_door :: Object
    pine_door = Object "pine door"
        "A pine door with a big glass panel.\n"
        "Shall i try opening it? - open"
        "hallway_ground_floor" [] False True nothing

    fiberboard_door :: Object
    fiberboard_door = Object "fiberboard door"
        ""
        ""
        "hallway_ground_floor" [] False True nothing

    fridge :: Object
    fridge = Object "fridge"
        "Oooh, it''s time to update this old refrigerator. Buzzing like a plane on the runway.\n"
        ""
        "room1" [] False True nothing

    sofa :: Object
    sofa = Object "sofa"
        "What an old shabby sofa. How can you sit on it?\n"
        ""
        "room1" [] False False nothing

    wall_clock :: Object
    wall_clock = Object "wall clock"
        "It ain''t working from 1:37. Maybe its a sign???\n"
        ""
        "room1" [] True False nothing

    stove :: Object
    stove = Object "stove"
        "White stove, surprisingly clean. Is rarely used.\n"
        ""
        "room1" [] True False nothing

    wardrobe :: Object
    wardrobe = Object "wardrobe"
        "A large oak wardrobe closes the passage to the rooms on the 2nd floor.\n"
        ""
        "corridor_1_floor" [] False True nothing

    carpet :: Object
    carpet = Object "carpet"
        "Great modern carpet. The truth does not fit into the interior of the house a little, looks suspicious.\n"
        ""
        "room3" [] False False nothing

    acoustic_guitar :: Object
    acoustic_guitar = Object "acoustic guitar"
        "Some strings are missings.\n"
        ""
        "room3" [] True False nothing

    poster :: Object
    poster = Object "poster"
        "Metallica poster with a dark falcon on it.\n"
        ""
        "room3" [] True False nothing

    music_stand :: Object
    music_stand = Object "music stand"
        "Music stand with some sheets.\n"
        ""
        "room3" [] True False nothing

    armchair :: Object
    armchair = Object "armchair"
        "A chair is like a chair. lol what else to say.\n"
        ""
        "room4" [] True False nothing

    work_table :: Object
    work_table = Object "work_table"
        "It''s clear, mkay..\n"
        ""
        "room4" [] False False nothing

    picture :: Object
    picture = Object "picture"
        "Is it a picture of a woman. I wonder who it is, on the back it is signed 'Jules 1978'.\n"
        ""
        "room4" [] True False nothing

    case :: Object
    case = Object "case"
        "You found a case! You need to enter a four-digit number. To open this case.\n"
        ""
        "room4" [laptop] False True code

    code :: Object
    code = Object "code" "1337" "" "" "" [] True False nothing

    laptop :: Object
    laptop = Object "laptop"
        "Eeeee, I found! - take'\n"
        ""
        "room4" [] True False nothing


    litter_box :: Object
    litter_box = Object "litter box"
        "Blue litter box with sand. Fortunately with no wastes.\n"
        ""
        "room5" [] True False nothing

    cat :: Object
    cat = Object "cat"
        "Black cat with white paws and belly. It still sleep even when I opened door.\n"
        ""
        "room5" [] False False nothing

    beanbag_chair :: Object
    beanbag_chair = Object "beanbag chair"
        "Big beanbag chair full covered in cat hair.\n"
        ""
        "room5" [] False False nothing

    scratching_post :: Object
    scratching_post = Object "scratching post"
        "Cat claw scratcher with hanging ball.\n"
        ""
        "room5" [] False False nothing