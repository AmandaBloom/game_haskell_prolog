import State
import Utils
import Data.List (isPrefixOf)


printIntroduction = printLines introductionText
printInstructions = printLines instructionsText

parseCmd :: String -> State -> State
parseCmd cmd state
            --  | isPrefixOf "look at" cmd    = lookAt (drop 8 cmd)
             | isPrefixOf "go"   cmd    = goTo (drop 3 cmd) state
             | isPrefixOf "take"    cmd    = takeObj (drop 5 cmd) state
             | otherwise                   = showInvalid state

gameLoop :: State -> IO (State)
gameLoop state = do
    printState state
    cmd <- readCommand
    if cmd /= "quit" && not (dead state) then gameLoop (
        case cmd of
            "instructions" -> showInstructions state
            "look" -> lookAround state
            "i" -> showInventory state
            "inventory" -> showInventory state
            "go back" -> goBack state
            "drop" -> dropObj state
            _ -> do parseCmd cmd state
        )
    else return state

main :: IO State
main = do
    printIntroduction
    printInstructions
    gameLoop initState