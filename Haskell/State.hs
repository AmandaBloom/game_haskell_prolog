module State where
    import Objects
    import Rooms
    import Prelude hiding (show)
    import Utils
    import Data.Maybe
    import Data.HashMap.Strict as HM

    data State = State {
            show :: [String],
            currentRoom :: String,
            inventory :: [Object],
            time :: Int,
            dead :: Bool,
            definedObjects :: [Object],
            pathStack :: [String],
            rooms :: HashMap String Room,
            roomHas :: HashMap String [Object],
            roomPassage :: HashMap String [Room]
        } deriving (Show)

    initState :: State
    initState = State [] "hallwayGroundFloor" [] 60 False
        [oldChair,carKeys,doormat,pineDoor,oakDoor,fiberboardDoor] []
        (HM.fromList [
            ("hallwayGroundFloor", hallwayGroundFloor),
            ("corridor1Floor", corridor1Floor),
            ("room1", room1),
            ("room2", room2),
            ("room3", room3),
            ("room4", room4),
            ("room5", room5)
        ])
        (HM.fromList [
            ("hallwayGroundFloor", Rooms.has hallwayGroundFloor),
            ("corridor1Floor", Rooms.has corridor1Floor),
            ("room1", Rooms.has room1),
            ("room2", Rooms.has room2),
            ("room3", Rooms.has room3),
            ("room4", Rooms.has room4),
            ("room5", Rooms.has room5)
        ])
        (HM.fromList [
            ("hallwayGroundFloor", Rooms.passage hallwayGroundFloor),
            ("corridor1Floor", Rooms.passage corridor1Floor),
            ("room1", Rooms.passage room1),
            ("room2", Rooms.passage room2),
            ("room3", Rooms.passage room3),
            ("room4", Rooms.passage room4),
            ("room5", Rooms.passage room5)
        ])

    printState :: State -> IO ()
    printState state = printLines(show state)

    showInstructions :: State -> State
    showInstructions state = state {show = instructionsText}

    showInvalid :: State -> State
    showInvalid state = state {show = invalidCommandText}

    showInventory :: State -> State
    showInventory state = do
        if length (inventory state) > 0 then
            state {show = "Your inventory:" : Prelude.map Objects.name (inventory state)}
        else state {show = ["Your inventory is empty"]}

    lookAround :: State -> State
    lookAround state = state {show = (getRoomDescription (currentRoom state) state) }

    inspect :: String -> State -> State
    inspect name state = do
        let obj = getObjByName name
        if (Rooms.name (getCurrentRoom state)) == (isAt obj) then
            case name of
                "doormat" -> state {
                    show = [(Objects.description obj) ++ (Objects.actions obj) ++ ("Here is a zincKkey. Shall i pick it up?")],
                    roomHas = addObj zincKey (currentRoom state) state
                }
                _ -> state {show = [(Objects.description obj) ++ (Objects.actions obj)]}
        else
            state {show = ["It smells like 404 to me. Something went wrong"]}

    go :: String -> State -> State
    go roomName state = do
        let passages = fromMaybe [Rooms.nothing] (HM.lookup (currentRoom state) (roomPassage state))
        if roomName == "outside" then
            checkWin state
        else
            if elem roomName (Prelude.map Rooms.name passages) then
                state {show = (getRoomDescription roomName state),
                        currentRoom = roomName,
                        pathStack = (pathStack state ++ [currentRoom state])
                    }
            else
                state {show = [("Cant go there")]}

    goBack :: State -> State
    goBack state = do
        let roomName = last (pathStack state)
        if length (pathStack state) > 0 then
            state {show = (getRoomDescription roomName state),
                    currentRoom = roomName,
                    pathStack = (init (pathStack state))
                }
        else
            state {show = ["something went wrong"]}

    takeObj :: String -> State -> State
    takeObj object state = do
        let obj = getObjByName object
        let roomName = currentRoom state
        if isInRoom object roomName state then
            if isTakeable obj then
                state {
                    show = [("You have picked the ") ++ (object)],
                    roomHas = rmObj obj roomName state,
                    inventory = (inventory state) ++ [obj]
                }
            else
                state {show = [("It's too heavy")]}
        else
            state {show = [("I don't see it here")]}

    dropObj :: String -> State -> State
    dropObj object state = do
        let obj = getObjByName object
        let roomName = currentRoom state
        if isInInvertory object state then
            if length (inventory state) == 1 then
                state {
                    show = [("You have dropped the ") ++ (object)],
                    roomHas = addObj obj (currentRoom state) state,
                    inventory = []
                }
            else
                state {
                    show = [("You have dropped the ") ++ (object)],
                    roomHas = addObj obj (currentRoom state) state,
                    inventory = Prelude.filter (\x -> x /= obj) (inventory state)
                }
        else
            state {show = [("You aren't holding it!")]}

    openObj :: String -> State -> State
    openObj object state = do
        let obj = getObjByName object
        let roomName = currentRoom state
        if isInRoom object roomName state then
            if isLocked obj then
                if length (openWith obj) > 0 then
                    if isInInvertory (Objects.name ((openWith obj) !! 0)) state then
                        case object of
                            "oakDoor" -> state {
                                show = [("You have openned the ") ++ (object)],
                                roomPassage = addPassage corridor1Floor roomName state
                            }
                            "safe" -> state {
                                show = [("You have openned the ") ++ (object)],
                                roomHas = addObj laptop roomName state
                            }
                            _ -> state {show = [("Not Implemented \nerror in openObj case 1")]}
                    else
                        state {show = [("I can't open it")]}
                else
                    case object of
                        "pineDoor" -> state {
                            show = [("You have openned the ") ++ (object)],
                            roomPassage = addPassage room2 roomName state
                        }
                        _ -> state {show = [("Not Implemented \nerror in openObj case 2")]}
            else
                state {show = [("I can't open it")]}
        else
            state {show = [("I don't see it here")]}

    moveObj :: String -> State -> State
    moveObj object state = do
        let obj = getObjByName object
        let room = currentRoom state
        if isInRoom object room state then
            if isMoved obj then
                state {
                    show = [("You have moved the ") ++ (object)]
                }
            else
                state {show = [("It's too heavy")]}
        else
            state {show = [("I don't see it here")]}

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
        "instructions      -- to see these instructions.",
        "go                -- Enter the room.",
        "back / b          -- Enter the previous room.",
        "take / t          -- Pick up an object.",
        "drop / d          -- Put down an object.",
        "inventory / i     -- Check inventory.",
        "look / l          -- Look around you again.",
        "inspect           -- Look at smth in room.",
        "open / o          -- Open at smth in room,",
        "move / m          -- Move at smth in room.",
        "press / p         -- Press the button.",
        "quit / q          -- to end the game and quit.",
        ""
        ]

    invalidCommandText ::[String]
    invalidCommandText = ["You can't do that :(", ""]

    isInRoom :: String -> String -> State -> Bool
    isInRoom object roomName state = elem object (Prelude.map Objects.name ((roomHas state) ! roomName))

    isInInvertory :: String -> State -> Bool
    isInInvertory object state = elem object (Prelude.map Objects.name (inventory state))

    getCurrentRoom :: State -> Room
    getCurrentRoom state = fromMaybe Rooms.nothing (HM.lookup (currentRoom state) (rooms state))

    getRoom :: String -> State -> Room
    getRoom roomName state = fromMaybe Rooms.nothing (HM.lookup roomName (rooms state))

    getRoomDescription :: String -> State -> [String]
    getRoomDescription roomName state =
        (getRoomInterior roomName state) ++ (getRoomPassages roomName state)

    getRoomInterior :: String -> State -> [String]
    getRoomInterior roomName state =
        Rooms.description (getRoom roomName state) : "We gotta: " :Prelude.map Objects.name ( (roomHas state) ! roomName)

    getRoomPassages :: String ->  State -> [String]
    getRoomPassages roomName state =
        "\nFrom here you can go to" : Prelude.map Rooms.name ((roomPassage state) ! roomName)

    addObj :: Object -> String -> State -> HashMap String [Object]
    addObj obj roomName state =
        insertWith f roomName [obj] (roomHas state)
            where f new old = old ++ new

    rmObj :: Object -> String -> State -> HashMap String [Object]
    rmObj obj roomName state =
        insertWith f roomName [obj] (roomHas state)
            where f new old = Prelude.filter (\x -> x /= (new !! 0 )) old

    -- rmObj :: Object -> String -> State -> HashMap String [Object]
    -- rmObj obj roomName state =
    --     alter f roomName (roomHas state)
    --         where f (Just old) = Just (Prelude.filter (\x -> x /= obj) old)

    addPassage :: Room -> String -> State -> HashMap String [Room]
    addPassage passage roomName state =
        insertWith f roomName [passage] (roomPassage state)
            where f new old = old ++ new

    rmPassage :: Room -> String -> State -> HashMap String [Room]
    rmPassage passage roomName state =
        insertWith f roomName [passage] (roomPassage state)
            where f new old = Prelude.filter (\x -> x /= (new !! 0 )) old

    checkWin :: State -> State
    checkWin state = do
        if isInInvertory "laptop" state then
            state {
                show = [("Congratulation, Mission completed.") ++ (" Press Enter to exit.")],
                dead = True
            }
        else
            state {
                show = [("No laptop found. Mission failed.") ++ (" Press Enter to exit.")],
                dead = True
            }
