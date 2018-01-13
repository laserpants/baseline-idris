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
  initReadline
  addDictEntry "foo"
  addDictEntry "baz"
  addDictEntry "encore"
  addDictEntry "pasta"
  addDictEntry "crocodile"
  addDictEntry "telephone"
  addDictEntry "telegraph"
  loop
