-- <Agent Of Fortune Game> by Roman Ishchuk, Denys Savytskyi, Tomasz Pawlak


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
    
-- note that the game loop may take the game state as
-- an argument, eg. gameLoop :: State -> IO ()
gameLoop :: IO ()
gameLoop = do
    cmd <- readCommand
    case cmd of
        "instructions" -> do printInstructions
                             gameLoop

        
main = do
    printIntroduction
    printInstructions
    gameLoop

