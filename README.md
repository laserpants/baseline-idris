# baseline-idris

This project provides FFI bindings for the [editline](https://github.com/troglobit/editline) library, to implement basic readline functionality in Idris. The name *editline-idris* would make sense if the API was more complete.

## Usage

## API

#### `baseline : String -> IO (Maybe String)`

#### `addDictEntry : String -> IO ()`

#### `addDictEntries : Foldable t => t String -> IO ()`
