module Utils where
    import Objects
    import Rooms
    import Data.Char
    import System.IO
    -- print strings from list in separate lines
    printLines :: [String] -> IO ()
    printLines xs = putStr (unlines xs)

    readCommand :: IO String
    readCommand = do
        putStr "> "
        hFlush stdout
        xs <- getLine
        return xs

    lowercase = map toLower

    getRoomDescription :: String -> [String]
    getRoomDescription roomName =
        case roomName of
            "hallway_ground_floor" -> Rooms.description hallway_ground_floor : "We gotta: " :map Objects.name (Rooms.has hallway_ground_floor)
            "corridor_1_floor" -> Rooms.description corridor_1_floor : "We gotta: " :map Objects.name (Rooms.has corridor_1_floor)
            "room1" -> Rooms.description room1 : "We gotta: " :map Objects.name (Rooms.has room1)
            "room2" -> Rooms.description room2 : "We gotta: " :map Objects.name (Rooms.has room2)
            "room3" -> Rooms.description room3 : "We gotta: " :map Objects.name (Rooms.has room3)
            "room4" -> Rooms.description room4 : "We gotta: " :map Objects.name (Rooms.has room4)
            "room5" -> Rooms.description room5 : "We gotta: " :map Objects.name (Rooms.has room5)