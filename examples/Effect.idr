module Main

import Effect.Baseline
import Effect.StdIO
import Effects
import Baseline

program : Eff () [BASELINE, STDIO]
program = do
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
where
  loop : Eff () [BASELINE, STDIO]
  loop = case !(baseline "$> ") of
              Nothing => putStrLn "Exit!"
              Just "" => loop
              Just s  => do
                putStrLn ("You typed: " ++ s)
                loop

main : IO ()
main = run program
