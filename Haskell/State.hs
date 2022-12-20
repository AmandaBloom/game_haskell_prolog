module State where
    import Objects
    import Rooms
    import Prelude hiding (show)
    import Utils

    data State = State {
            show :: [String],
            imAt :: String,
            holding :: [Object],
            inventory :: [Object],
            currentRoom :: String,
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
    showInventory state = do
        if length (inventory state) > 0 then
            state {show = "Your inventory:" : map Objects.name (inventory state)}
        else state {show = ["Your inventory is empty"]}

    lookAround :: State -> State
    lookAround state = state {show = (getRoomDescription (imAt state)) }

    inspect :: String -> State -> State
    inspect name state = do
        let obj = getObjByName name
        if (imAt state) == (isAt obj) then
            state {show = [(Objects.description obj) ++ (Objects.actions obj)]}
        else
            state {show = ["It smells like 404 to me. Something went wrong"]}

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

    introductionText :: [String]
    introductionText = [
        "Welcome Agent!. The world is a dangerous place. Mister Zero wants to make it",
        "even worse. Our intelligence has proven he has nuclear codes and he''s gonna",
        "use them to destroy The World. That''s why you were sent to his house. Search",
        "for the Laptop with codes and protect our future...",
        "Be quick, he is gonna come back in any time... ",
        "",

        "...............Agent Of Fortune Game...............",
        "",
        "Finally... You entered Mister Zero''s crib. Front door appears to be intact.",
        "You''re into the hallway_ground_floor. On the small table there''s note - it says",
        "he will be back soon, so you have 10 minutes to leave the house, hurry up",
        ""
        ]

    instructionsText :: [String]
    instructionsText = [
        "Available commands are:",
        "",
        "instructions  -- to see these instructions.",
        "go            -- Enter the room.",
        "back          -- Enter the previous room.",
        "take          -- Pick up an object.",
        "drop          -- Put down an object.",
        "inventory     -- Check inventory.",
        "look          -- Look around you again.",
        "inspect       -- Look at smth in room.",
        "open          -- Open at smth in room,",
        "move          -- Move at smth in room.",
        "turn_off      -- Turn smth off.",
        "press         -- Press the button.",
        "time_left     -- Check how much time is left",
        "quit          -- to end the game and quit.",
        ""
        ]

    invalidCommandText ::[String]
    invalidCommandText = ["You can't do that :(", ""]