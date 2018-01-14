module Baseline

%include C "baseline_idris.h"
%lib     C "editline"
%link    C "baseline_idris.o"

readline_gets : String -> IO String
readline_gets = foreign FFI_C "readline_gets" (String -> IO String)

export
baseline : String -> IO (Maybe String)
baseline prompt = do
  text <- readline_gets prompt
  null <- nullStr text
  pure (toMaybe (not null) text)

export
addDictEntry : String -> IO ()
addDictEntry = foreign FFI_C "add_dict_entry" (String -> IO ())

export
addDictEntries : Foldable t => t String -> IO ()
addDictEntries es = for_ es addDictEntry
