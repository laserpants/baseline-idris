module Main

import Editline

loop : IO ()
loop = do
  str <- readline "> "
  case str of
       Nothing => putStrLn "Exit!"
       Just "" => loop
       Just s  => do
         putStrLn ("You typed: " ++ s)
         loop

main : IO ()
main = do
  addDictEntries
    [ "foo"
    , "baz"
    , "encore"
    , "pasta"
    , "crocodile"
    , "telephone"
    , "telegraph"
    , "telegram"
    ]
  loop
