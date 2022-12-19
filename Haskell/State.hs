-- <Agent Of Fortune Game> by Roman Ishchuk, Denys Savytskyi, Tomasz Pawlak
module State where
    import Objects
    import Rooms
    import Prelude hiding (show)

    data State = State {
            show :: [String],
            imAt :: String, -- at object or in room
            holding :: [Object], -- just one
            inventory :: [Object],
            currentRoom :: String, -- show room
            time :: Int,
            dead :: Bool,
            definedItems :: [Object]
        } deriving (Show)

    initState :: State
    initState = State [] "hallway_ground_floor" [] [] "hallway_ground_floor" 60 False  [old_chair,car_keys,doormat,pine_door,oak_door,fiberboard_door]
    
    --printState :: State -> IO ()
    --printState state = printLines(show state)
    printLines :: [String] -> IO ()
    printLines xs = putStr (unlines xs)

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
        let it = getItem object state in
        if Objects.isAt it == (currentRoom state) then
            state {show = ["You got to " ++ object], imAt = object}
        else state {show = ["You can't go there."]}

    goBack :: State -> State
    goBack state = state {show = ["You're back at " ++ currentRoom state], imAt = (currentRoom state)}
    
    getItem :: String -> State -> Object
    getItem object state = 
        let matched = (filter (\x -> lowercase(Objects.name x) == object) (definedItems state)) in
            if matched /= [] then head (matched)
            else nothing

    takeObj :: String -> State -> State
    takeObj object state = 
        if lowercase(imAt state) == lowercase(object) then
            let it = getItem object state in
            if it /= nothing then do
                (if isTakeable it then state {show=["You're holding " ++ object], holding = [it]}
                 else state {show = ["You can't take that."]})
            else state {show = ["You can't take that from this place."]}
        else state {show = ["You can't take that from this place"]}

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

    
    pressButton :: State -> State
    pressButton state =
        if Objects.name (head(holding state)) == "remote" then
            if imAt state == Objects.name blinkingLight then
                state {show=[Objects.description door]}
            else state {show=["It's not working. Maybe I should get closer"]}
        else state {show=["You're not holding the remote."]}

    unlock :: String -> State -> State
    unlock object state = 
        if lowercase(imAt state) == lowercase(object) then
            let it = getItem object state in
            if it /= nothing then do
                (if isTakeable it then state {show=["You're holding " ++ object], holding = [it]}
                 else state {show = ["You can't take that."]})
            else state {show = ["You can't take that from this place"]}
        else state {show = ["You can't take that from this place"]}


    invalidCommandText ::[String]
    invalidCommandText = ["You can't do that :(", ""]