# baseline-idris

This project provides a high-level line-editing API via FFI bindings to the 
[Editline](https://github.com/troglobit/editline) library. It aims to implement
basic readline functionality in [Idris](https://github.com/idris-lang). Perhaps 
the name *editline-idris* would be suitable if the API was a bit more complete. 
:stuck_out_tongue:

## Preliminaries

To use this library, first [build and install Editline](https://github.com/troglobit/editline#build--install). 

## Installing

Install the package using:

```
idris --install baseline-idris.ipkg
```

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
```

### Save and restore history

See `examples/History.idr` or above snippet. :point_up_2:

## API

#### `baseline : (prompt : String) -> IO (Maybe String)` 
#### `baseline : (prompt : String) -> Eff (Maybe String) [BASELINE] *`

Run the readline prompt and save input to history.

#### `addDictEntry : (entry : String) -> IO ()` 
#### `addDictEntry : (entry : String) -> Eff () [BASELINE] *`

Add an entry to tab completion dictionary.

#### `addDictEntries : Foldable t => (entries : t String) -> IO ()` 
#### `addDictEntries : Traversable t => (entries : t String) -> Eff () [BASELINE] *` 

Add multiple entries to tab completion dictionary.

#### `readHistory : (filename : String) -> IO ()`
#### `readHistory : (filename : String) -> Eff () [BASELINE] *`

Recover saved history from file.

#### `writeHistory : (filename : String) -> IO ()`
#### `writeHistory : (filename : String) -> Eff () [BASELINE] *`

Save history to file.

---

*) Use `import Effect.Baseline`.

## Roadmap

- [ ] Ability to take callback for custom tab completion (requires FFI support)
- [ ] Implement more of Editline's API
- [ ] Readline-like reverse search
