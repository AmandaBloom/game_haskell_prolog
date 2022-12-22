module Utils where
    import Objects
    import Rooms
    import Data.Char
    import System.IO
    import Data.UnixTime

    -- print strings from list in separate lines
    printLines :: [String] -> IO ()
    printLines xs = putStr (unlines xs)

    readCommand :: IO String
    readCommand = do
        putStr "> "
        hFlush stdout
        xs <- getLine
        return xs

    getTime :: IO UnixTime
    getTime = do
        time <- getUnixTime
        return time