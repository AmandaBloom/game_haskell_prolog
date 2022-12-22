import State
import Rooms
import Utils
import Data.List.Split
import Data.HashMap.Strict as HM
import Objects
import Data.UnixTime

printIntroduction = printLines introductionText
printInstructions = printLines instructionsText


gameLoop :: State -> IO (State)
gameLoop state = do
    printState state
    cmd <- readCommand
    uTime <- getUnixTime
    let now = read (Prelude.show (toEpochTime uTime)) :: Int
    let splited = splitOn " " cmd
    let action = splited !! 0
    let arg = splited !! 1
    if action /= "quit" && action /= "q" && not (dead state) then gameLoop (
            if now > (endTime state) then
                showTimeOut state
            else
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
                "turnOff" -> turnOff arg state
                "timeLeft" -> timeLeft now state
                "tl" -> timeLeft now state
                _ -> showInvalid state
        )
    else return state

main :: IO State
main = do

    startTime <- getUnixTime
    let endTime = toEpochTime startTime + 600
    let endTime_int = read (Prelude.show endTime) :: Int

    let initState = State [] "hallwayGroundFloor" [] 60 False [oldChair,carKeys,doormat,pineDoor,oakDoor,fiberboardDoor] [] (HM.fromList [
            ("hallwayGroundFloor", hallwayGroundFloor),
            ("corridor1Floor", corridor1Floor),
            ("room1", room1),
            ("room2", room2),
            ("room3", room3),
            ("room4", room4),
            ("room5", room5)]) (HM.fromList [
            ("hallwayGroundFloor", Rooms.has hallwayGroundFloor),
            ("corridor1Floor", Rooms.has corridor1Floor),
            ("room1", Rooms.has room1),
            ("room2", Rooms.has room2),
            ("room3", Rooms.has room3),
            ("room4", Rooms.has room4),
            ("room5", Rooms.has room5)]) (HM.fromList [
            ("hallwayGroundFloor", Rooms.passage hallwayGroundFloor),
            ("corridor1Floor", Rooms.passage corridor1Floor),
            ("room1", Rooms.passage room1),
            ("room2", Rooms.passage room2),
            ("room3", Rooms.passage room3),
            ("room4", Rooms.passage room4),
            ("room5", Rooms.passage room5)]) (endTime_int)


    printIntroduction
    printInstructions
    gameLoop initState
