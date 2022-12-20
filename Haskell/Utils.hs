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

    getRoomDescription :: Room -> [String]
    getRoomDescription room =
        getRoomInterior room ++ getRoomPassages room

    getRoomInterior :: Room -> [String]
    getRoomInterior room =
        Rooms.description room : "We gotta: " :map Objects.name (Rooms.has room)

    getRoomPassages :: Room -> [String]
    getRoomPassages room =
        "\nFrom here you can go to" : map Rooms.name (Rooms.passage room)


