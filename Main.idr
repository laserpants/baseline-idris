module Main

import Editline

main : IO ()
main = do
  str <- readline "> "
  case str of
       Nothing => putStrLn "Exit!"
       Just s => putStrLn ("You typed" ++ s)
