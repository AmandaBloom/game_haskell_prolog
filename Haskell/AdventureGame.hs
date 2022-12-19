-- <Agent Of Fortune Game> by Roman Ishchuk, Denys Savytskyi, Tomasz Pawlak
import Data.List (map, isPrefixOf, (\\))
import Data.IORef
import Data.Map (fromList, member, findWithDefault)
import Data.Char
import Text.Printf

introductionText = [
    "Welcome Agent!. The world is a dangerous place. Mister Zero wants to make",
    "it even worse. Our intelligence has proven he has nuclear codes and he''s ",
    "gonna use them to destroy The World. That''s why you were sent to his house.",
    "Search for the Laptop with codes and protect our future...",
    "Be quick, he is gonna come back in any time... ",
    "",

    "...............Agent Of Fortune Game...............",
    "",
    "Finally... You entered Mister Zero''s crib. Front door appears to be intact",
    "You''re into the hallway_ground_floor. On the small table there''s note - ",
    "it says he will be back soon, so you have 10 minutes to leave the house,",
    "hurry up"
    ]

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

hallway_ground_floorDesciptionText = [
    "I\'m in hallway_ground_floor",
    "What a long corridor. For a long time Mister Zero hasn\'t done no",
    "cleaning here. What huge spiders are sitting on the ceiling",
    ""
    ]

room1DescriptionText = [
    "You are in the first room. Damn, the door to the next room is closed",
    "I have to find the key to the door to open the door to the second room.",
    ""
    ]

room2DescriptionText = [
    "It''s so empty here, like after a robbery",
    ""
    ]

corridor1stFloorDescriptionText = [
    "Hmm, what a fancy wardrobe is right in my path",
    ""
    ]

room3DescriptionText = [
    "All the wall a covered with acoustic boards in this room.",
    ""
    ]

room4DescriptionText = [
    "Small room.",
    "There was a work table and an armchair in the room, and...",
    "a picture hung on the wall."
    ]

room5DescriptionText = [
    "Another room, it seems like it''s his office",
    ""
    ]

hallway_ground_floorObjects = [
    "old_chair",
    "car_keys",
    "doormat",
    "pine_door",
    "oak_door",
    "fiberboard_door"
    ]

room1Objects = [
    "wall_clock",
    "sofa",
    "fridge",
    "stove"
    ]

room3Objects = [
    "carpet",
    "music_stand",
    "acoustic_guitar",
    "poster"
    ]

takeableObjects = [
    "car_keys"
    ]

-- print strings from list in separate lines
printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)
                  
printIntroduction = printLines introductionText
printInstructions = printLines instructionsText

readCommand :: IO String
readCommand = do
    putStr "> "
    xs <- getLine
    return xs

--gameplay functions
describe :: String -> String
describe x | x=="hallway_ground_floor" = head hallway_ground_floorDesciptionText
           | x=="room1" = head room1DescriptionText
           | x=="old_chair" = "Looks like he likes old things, but he doesn''t take care of them. Very well...\n"
           | x=="x" = "x"
           | x=="x" = "x"
           | x=="x" = "x"
           | otherwise = ""

notice :: String -> String
notice x = "Ooh there's a " ++ x ++ "."

printhallway_ground_floorDescription = do
    printLines hallway_ground_floorDesciptionText
    printLines (map notice hallway_ground_floorObjects)

printroom1Description = do
    printLines room1DescriptionText
    printLines (map notice room1Objects)

lookAround :: IORef String -> IO()                      
lookAround currentRoom = do
    arg <- readIORef currentRoom
    case arg of
        "hallway_ground_floor" -> do printhallway_ground_floorDescription
        "room1" -> do printroom1Description

showInventory :: IORef [String] -> IO()
showInventory inventory = do
    i <- readIORef inventory 
    if null i then putStr "You haven't got anything.\n"
    else do putStr "You've got: \n"
            printLines i

go :: String -> IORef String -> IO()
go x imAt = do  writeIORef imAt (x)
                putStr ("You're at " ++ x ++ ".\n")
                putStr (describe x)

goBack :: IORef String -> IORef String -> IO()
goBack currentRoom imAt = do
    x <- readIORef currentRoom
    go x imAt

checkGo :: String -> String -> IORef String -> String -> IO()
checkGo x currentRoom imAtRef imAtStr
    |x == imAtStr                         = putStr "You're already here.\n"
    |currentRoom == "hallway_ground_floor" && elem x hallway_ground_floorObjects = go x imAtRef
    |currentRoom == "room1" && elem x room1Objects = go x imAtRef
    |otherwise = putStr ("You can't go to " ++ x ++ ". Try going back.")

goTo :: String -> IORef String -> IORef String -> IO()
goTo x currentRoom imAt = do
    currentRoom <- readIORef currentRoom
    imAtStr <- readIORef imAt
    checkGo x currentRoom imAt imAtStr

--takeObj :: String -> IORef String -> IORef String -> IO()
--takeObj x holding imAt = do
--    at <- readIORef imAt
--    h <- readIORef holding
--    if h == "nothing" then
--        if member x takeableObjects && (findWithDefault "" x takeableObjects) == at then writeIORef holding x 
--        else putStr ("You can't take " ++ x)
--    else putStr ("You're holding " ++ h ++". Put it in inventory.")

dropObj :: IORef String -> IO()
dropObj holding = do
    h <- readIORef holding
    if h == "nothing" then putStr "You're not holding anything."
    else writeIORef holding "nothing"

putInInventory :: IORef [String] -> IORef String -> IO()
putInInventory inventory holding = do
    h <- readIORef holding
    modifyIORef' inventory (++[h])
    dropObj holding 

getFromInventory :: String -> IORef [String] -> IORef String -> IO()
getFromInventory x inventory holding = do
    i <- readIORef inventory
    h <- readIORef holding
    if elem x i then
        if h == "nothing" then do 
            writeIORef holding (x)
            modifyIORef' inventory (\\[x])
        else putStr ("You're holding " ++ h ++". Put it in inventory.")
    else putStr ("You don't have " ++ x)


parseCmd :: String -> IORef [String] -> IORef String -> IORef String -> IORef String -> IO()
parseCmd cmd inventory holding currentRoom imAt
             | isPrefixOf "look at" cmd    = putStr (describe (drop 8 cmd))
             | isPrefixOf "go to"   cmd    = goTo (drop 6 cmd) currentRoom imAt
--             | isPrefixOf "take"    cmd    = takeObj (drop 5 cmd) holding imAt
             | isPrefixOf "get from i" cmd = getFromInventory (drop 11 cmd) inventory holding
             | otherwise                   = printLines ["Unknown command.", ""]
    
-- note that the game loop may take the game state as
-- an argument, eg. gameLoop :: State -> IO ()
gameLoop :: IORef [String] -> IORef String -> IORef String -> IORef String -> IORef Int -> IO ()
gameLoop inventory holding currentRoom imAt time = do
    t <- readIORef time
    modifyIORef' time (+(-1))
    if (mod t 5) == 0 then printf "You have %d moves left.\n" t
    else printf ""
    cmd <- readCommand
    case cmd of
        "instructions" -> do printInstructions
                             gameLoop inventory holding currentRoom imAt time
        "look" -> do lookAround currentRoom
                     gameLoop inventory holding currentRoom imAt time
        "i" -> do showInventory inventory
                  gameLoop inventory holding currentRoom imAt time
        "inventory" -> do showInventory inventory
                          gameLoop inventory holding currentRoom imAt time
        "go back" -> do goBack currentRoom imAt
                        gameLoop inventory holding currentRoom imAt time
        "drop" -> do dropObj holding
                     gameLoop inventory holding currentRoom imAt time
        "put in i" -> do putInInventory inventory holding
                         gameLoop inventory holding currentRoom imAt time
        "quit" -> return ()
        _ -> do parseCmd cmd inventory holding currentRoom imAt
                gameLoop inventory holding currentRoom imAt time

main = do
    inventory <- newIORef ([] :: [String])
    holding <- newIORef ("nothing" :: String)
    currentRoom <- newIORef ("hallway_ground_floor" :: String)
    imAt <- newIORef ("hallway_ground_floor" :: String)
    time <- newIORef (60 :: Int)
    printIntroduction
    printInstructions
    printhallway_ground_floorDescription
    gameLoop inventory holding currentRoom imAt time