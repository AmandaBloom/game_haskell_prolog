import State
import Utils
import Data.List.Split

printIntroduction = printLines introductionText
printInstructions = printLines instructionsText


gameLoop :: State -> IO (State)
gameLoop state = do
    printState state
    cmd <- readCommand
    let splited = splitOn " " cmd
    let action = splited !! 0
    let arg = splited !! 1
    if action /= "quit" && action /= "q" && not (dead state) then gameLoop (
        case action of
            "instructions" -> showInstructions state
            "look" -> lookAround state
            "l" -> lookAround state
            "inventory" -> showInventory state
            "i" -> showInventory state
            "inspect" -> inspect arg state
            "go" -> go arg state
            "back" -> goBack state
            "b" -> goBack state
            "take" -> takeObj arg state
            "t" -> takeObj arg state
            "drop" -> dropObj arg state
            "d" -> dropObj arg state
            "open" -> openObj arg state
            "o" -> openObj arg state
            "move" -> moveObj arg state
            "m" -> moveObj arg state
            _ -> showInvalid state
        )
    else return state

main :: IO State
main = do
    printIntroduction
    printInstructions
    gameLoop initState