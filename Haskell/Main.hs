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
    if action /= "quit" && not (dead state) then gameLoop (
        case action of
            "instructions" -> showInstructions state
            "look" -> lookAround state
            "i" -> showInventory state
            "inventory" -> showInventory state
            "go back" -> goBack state
            "drop" -> dropObj state
            "inspect" -> inspect arg state
            _ -> showInvalid state
        )
    else return state

main :: IO State
main = do
    printIntroduction
    printInstructions
    gameLoop initState