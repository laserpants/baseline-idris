module Main

import Baseline

loop : IO ()
loop = do
  str <- baseline "$> "
  case str of
       Just "" => loop
       Just s  => do
         putStrLn ("You typed: " ++ s)
         loop
       otherwise => pure ()

main : IO ()
main = do
  readHistory ".history"
  addDictEntries
    [ "lexicographic"
    , "mexico"
    , "existentialism" ]
  loop
  writeHistory ".history"
  putStrLn "Exit!"
