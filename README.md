# baseline-idris

This project provides FFI bindings for the 
[Editline](https://github.com/troglobit/editline) library, to implement basic 
readline functionality in [Idris](https://github.com/idris-lang). Perhaps the 
name *editline-idris* would be suitable if the API was a bit more complete. 
:stuck_out_tongue:

## Preliminaries

To use this library, first [build and install Editline](https://github.com/troglobit/editline#build--install). 
Then run <kbd>make</kbd> in this project's root directory to compile the C 
bindings.

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
```

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

---

*) Use `import Effect.Baseline`.

## Roadmap

- [ ] Ability to take callback for custom tab completion (requires FFI support)
- [ ] Implement more of Editline's API
- [ ] Readline-like reverse search
