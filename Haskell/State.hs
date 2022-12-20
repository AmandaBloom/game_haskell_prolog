module State where
    import Objects
    import Rooms
    import Prelude hiding (show)
    import Utils

    data State = State {
            show :: [String],
            imAt :: String, -- przy obiekcie lub w pokoju
            holding :: [Object], -- tylko 1
            inventory :: [Object],
            currentRoom :: String, -- w pokoju
            time :: Int,
            dead :: Bool,
            definedObjects :: [Object]
        } deriving (Show)

    initState :: State
    initState = State [] "hallway_ground_floor" [] [] "hallway_ground_floor" 60 False  [old_chair,car_keys,doormat,pine_door,oak_door,fiberboard_door]

    printState :: State -> IO ()
    printState state = printLines(show state)

    showInstructions :: State -> State
    showInstructions state = state {show = instructionsText}

    showInvalid :: State -> State
    showInvalid state = state {show = invalidCommandText}

    showInventory :: State -> State
    showInventory state = state {show = "Your inventory:" : map Objects.name (inventory state)}

    lookAround :: State -> State
    lookAround state = state {show = (getRoomDescription (imAt state)) }

    goTo :: String -> State -> State
    goTo object state =
        let it = getObject object state in
        if Objects.isAt it == (currentRoom state) then
            state {show = ["You got to " ++ object], imAt = object}
        else state {show = ["You can't go there."]}

    goBack :: State -> State
    goBack state = state {show = ["You're back at " ++ currentRoom state], imAt = (currentRoom state)}

    getObject :: String -> State -> Object
    getObject object state =
        let matched = (filter (\x -> lowercase(Objects.name x) == object) (definedObjects state)) in
            if matched /= [] then head (matched)
            else nothing

    takeObj :: String -> State -> State
    takeObj object state =
        if lowercase(imAt state) == lowercase(object) then
            let it = getObject object state in
            if it /= nothing then do
                (if isTakeable it then state {show=["You're holding " ++ object], holding = [it]}
                 else state {show = ["You can't take that. It's too heavy."]})
            else state {show = ["You can't take that. Get closer."]}
        else state {show = ["You can't take that. Get closer."]}

    dropObj :: State -> State
    dropObj state = state {show=["You dropped " ++ Objects.name (head(holding state))], holding= []}

    putInInventory :: State -> State
    putInInventory state = state {show=[Objects.name (head(holding state)) ++ " added to inventory"],
                                  inventory = (inventory state)++(holding state),
                                  holding= []}

    getFromInventory :: String -> State -> State
    getFromInventory object state =
        if holding state == [] then
            let it = (filter (\x -> lowercase(Objects.name x) == object) (inventory state)) in
                if it /= [] then
                    state {show=["You're holding "++(Objects.name (head(it)))],
                           holding=it,
                           inventory=(filter (\x -> lowercase(Objects.name x) /= object) (inventory state))}
                else state {show = ["You don't have it in your inventory."]}
        else state {show=["You're holding something. Drop or put it in inventory."]}

    unlock :: String -> State -> State
    unlock object state =
        if lowercase(imAt state) == lowercase(object) then
            let it = getObject object state in
            if it /= nothing then do
                (if isTakeable it then state {show=["You're holding " ++ object], holding = [it]}
                 else state {show = ["You can't take that. It's too heavy."]})
            else state {show = ["You can't take that. Get closer."]}
        else state {show = ["You can't take that. Get closer."]}

    introductionText :: [String]
    introductionText = [
        "You're a spy who's been tasked with stealing Dr. D's research on a remarkable new fuel that will take space travel to a new, unprecedented level.",
        "You must steal the research as quickly as possible before Dr. D. returns to his lab.",
        "",
        "You have successfully entered the home of Dr. D. You are behind the front door.",
        "From what you have been able to determine with your co-workers, Doctor D. should be back in half an hour (number of moves - X).",
        "Be careful what you do, remember that every move counts!.",
        ""
        ]

    instructionsText :: [String]
    instructionsText = [
        "Available commands are (params in UPPERCASE):",
        "",
        "look                  -- to look around you again.",
        -- "look at OBJECT        -- to look at something in the room.",
        "go to OBJECT          -- to get to a certain place.",
        "go back               -- to get back in the room.",
        "take OBJECT           -- to pick up an object.",
        "drop                  -- to put down the object you're holding.",
        "put in i              -- to put an object in inventory.",
        "get from i OBJECT     -- to get an object from inventory.",
        "inventory /i          -- to check inventory.",
        "instructions          -- to see this message again.",
        "quit                  -- to end the game and quit.",
        ""
        ]

    invalidCommandText ::[String]
    invalidCommandText = ["You can't do that :(", ""]