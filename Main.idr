module Main

import Editline

loop : IO ()
loop = do
  str <- readline "> "
  case str of
       Nothing => putStrLn "Exit!"
       Just "" => loop
       Just s  => do
         putStrLn ("You typed" ++ s)
         loop

main : IO ()
main = loop
