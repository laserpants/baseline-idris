module Editline

%include C "editline_idris.h"
%lib     C "editline"
%link    C "editline_idris.o"

readline_gets : String -> IO String
readline_gets = foreign FFI_C "readline_gets" (String -> IO String)

export
readline : String -> IO (Maybe String)
readline prompt = do
  text <- readline_gets prompt
  null <- nullStr text
  pure (toMaybe (not null) text)
