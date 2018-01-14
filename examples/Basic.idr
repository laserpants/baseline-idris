module Main

import Baseline

loop : IO ()
loop = do
  str <- baseline "$> "
  case str of
       Nothing => putStrLn "Exit!"
       Just "" => loop
       Just s  => do
         putStrLn ("You typed: " ++ s)
         loop

main : IO ()
main = do
  addDictEntries
    [ "multidiscipline"
    , "multivitamin"
    , "multiplex"
    , "monocrystalline"
    , "streamline"
    , "waterline"
    , "skyline"
    , "online"
    , "byline" ]
  loop
