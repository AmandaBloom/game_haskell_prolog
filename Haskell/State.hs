module State where
    import Objects
    import Rooms
    import Prelude hiding (show)
    import Utils

    data State = State {
            show :: [String],
            currentRoom :: Room,
            holding :: [Object],
            inventory :: [Object],
            time :: Int,
            dead :: Bool,
            definedObjects :: [Object],
            pathStack :: [Room]
        } deriving (Show)

    initState :: State
    initState = State [] hallwayGroundFloor [] [] 60 False [oldChair,carKeys,doormat,pineDoor,oakDoor,fiberboardDoor] []

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
    lookAround state = state {show = (getRoomDescription (currentRoom state)) }

    inspect :: String -> State -> State
    inspect name state = do
        let obj = getObjByName name
        if (Rooms.name (currentRoom state)) == (isAt obj) then
            state {show = [(Objects.description obj) ++ (Objects.actions obj)]}
        else
            state {show = ["It smells like 404 to me. Something went wrong"]}

    go :: String -> State -> State
    go roomName state = do
        let room = getRoomByName roomName
        let passages = Rooms.passage (currentRoom state)
        if elem (Rooms.name room) (map Rooms.name passages) then
            state {show = (getRoomDescription room),
                    currentRoom = room,
                    pathStack = (pathStack state ++ [currentRoom state]),
                    definedObjects = (Rooms.has room)
                }
        else
            state {show = [("Cant go there")]}

    goBack :: State -> State
    goBack state = do
        let room = last (pathStack state)
        if length (pathStack state) > 0 then
            state {show = (getRoomDescription room),
                    currentRoom = room,
                    pathStack = (init (pathStack state)),
                    definedObjects = (Rooms.has room)
                }
        else
            state {show = ["something went wrong"]}

    takeObj :: String -> State -> State
    takeObj object state = do
        let obj = getObjByName object
        let room = currentRoom state
        if elem object (map Objects.name (has room)) then
            if isTakeable obj then
                state {
                    show = [("You have picked the ") ++ (object)],
                    definedObjects = filter (\x -> x /= obj) (has room),
                    inventory = (inventory state) ++ [obj]
                }
            else
                state {show = [("It's too heavy")]}
        else
            state {show = [("I don't see it here")]}


    dropObj :: String -> State -> State
    dropObj object state = do
        let obj = getObjByName object
        let room = currentRoom state
        if elem object (map Objects.name (inventory state)) then
            if length (inventory state) == 1 then
                state {
                    show = [("You have dropped the ") ++ (object)],
                    definedObjects = (definedObjects state) ++ [obj],
                    inventory = []
                }
            else
                state {
                    show = [("You have dropped the ") ++ (object)],
                    definedObjects = (definedObjects state) ++ [obj],
                    inventory = filter (\x -> x /= obj) (inventory state)
                }
        else
            state {show = [("You aren't holding it!")]}

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
        "You''re into the hallwayGroundFloor. On the small table there''s note - it says",
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