module Baseline

%include C "baseline_idris.h"
%lib     C "editline"
%link    C "baseline_idris.o"

readline : String -> IO String
readline = foreign FFI_C "bl_readline" (String -> IO String)

||| Run the readline prompt and save input to history.
export
baseline : (prompt : String) -> IO (Maybe String)
baseline prompt = do
  text <- readline prompt
  null <- nullStr text
  pure (toMaybe (not null) text)

||| Add an entry to tab completion dictionary.
export
addDictEntry : (entry : String) -> IO ()
addDictEntry = foreign FFI_C "bl_add_dict_entry" (String -> IO ())

||| Add multiple entries to tab completion dictionary.
export
addDictEntries : Foldable t => (entries : t String) -> IO ()
addDictEntries es = for_ es addDictEntry

||| Recover saved history from file.
export
readHistory : (filename : String) -> IO ()
readHistory = foreign FFI_C "bl_read_history" (String -> IO ())

||| Save history to file.
export
writeHistory : (filename : String) -> IO ()
writeHistory = foreign FFI_C "bl_write_history" (String -> IO ())
