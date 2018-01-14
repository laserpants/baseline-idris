# baseline-idris

This project provides FFI bindings for the [editline](https://github.com/troglobit/editline) library, to implement basic readline functionality in [Idris](https://github.com/idris-lang). The name *editline-idris* would make sense if the API was slightly more complete.

## Usage

```idris
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
    , "monocrystalline"
    , "streamline"
    , "waterline"
    , "skyline"
    , "online"
    , "byline"
    ]
  loop
```

## API

#### `baseline : String -> IO (Maybe String)`

#### `addDictEntry : String -> IO ()`

#### `addDictEntries : Foldable t => t String -> IO ()`

## Roadmap
