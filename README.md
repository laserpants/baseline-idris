# baseline-idris

This project provides FFI bindings for the [editline](https://github.com/troglobit/editline) library, to implement basic readline functionality in [Idris](https://github.com/idris-lang). Perhaps the name *editline-idris* would be suitable if the API was a bit more complete.

## Usage

### Vanilla `IO` monad

`examples/Basic.idr`:

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
    , "multivitamin"
    , "multiplex"
    , "monocrystalline"
    , "streamline"
    , "waterline"
    , "skyline"
    , "online"
    , "byline" ]
  loop
```

### Effect

`examples/Effect.idr`:

```idris
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
  loop = do
    str <- baseline "$> "
    case str of
         Nothing => putStrLn "Exit!"
         Just "" => loop
         Just s  => do
           putStrLn ("You typed: " ++ s)
           loop

main : IO ()
main = run program
```

## API

`import Baseline`

#### `baseline : String -> IO (Maybe String)`

#### `addDictEntry : String -> IO ()`

#### `addDictEntries : Foldable t => t String -> IO ()`

### Effect

`import Effect.Baseline`

#### `baseline : String -> Eff (Maybe String) [BASELINE]`

#### `addDictEntry : String -> Eff () [BASELINE]`

#### `addDictEntries : List String -> Eff () [BASELINE]`

## Roadmap
