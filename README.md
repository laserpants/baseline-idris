# baseline-idris

This project provides FFI bindings for the [editline](https://github.com/troglobit/editline) library, to implement basic readline functionality in [Idris](https://github.com/idris-lang). Perhaps the name *editline-idris* would be suitable if the API was a bit more complete. :stuck_out_tongue:

## Preliminaries

To use this library, first [build and install editline](https://github.com/troglobit/editline#build--install).

Then run <kbd>make</kbd> in this project's root directory to compile the object file.

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

Run the readline prompt and save input to history.

#### `addDictEntry : String -> IO ()`

Add an entry to tab completion dictionary.

#### `addDictEntries : Foldable t => t String -> IO ()`

Add multiple entries to tab completion dictionary.

### Effect

`import Effect.Baseline`

#### `baseline : String -> Eff (Maybe String) [BASELINE]`

Run the readline prompt and save input to history.

#### `addDictEntry : String -> Eff () [BASELINE]`

Add an entry to tab completion dictionary.

#### `addDictEntries : List String -> Eff () [BASELINE]`

Add multiple entries to tab completion dictionary.

## Roadmap

- [ ] Ability to take callback for custom tab completion (requires FFI support)
- [ ] Implement more of editline's API
- [ ] Readline-like reverse search
