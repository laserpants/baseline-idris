module Main

import Effect.Baseline
import Effect.StdIO
import Effects
import Baseline

program : Eff () [BASELINE, STDIO]
program = do
  readHistory ".history"
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
  writeHistory ".history"
  putStrLn "Exit!"
where
  loop : Eff () [BASELINE, STDIO]
  loop = case !(baseline "$> ") of
              Just "" => loop
              Just s  => do
                putStrLn ("You typed: " ++ s)
                loop
              otherwise => pure ()

main : IO ()
main = run program
