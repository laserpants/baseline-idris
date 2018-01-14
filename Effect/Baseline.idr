module Effect.Baseline

import Effects
import Baseline

%access public export

data Baseline : Effect where
  Readline : String -> sig Baseline (Maybe String)
  AddDictEntry : String -> sig Baseline ()
  AddDictEntries : Traversable t => t String -> sig Baseline ()
  ReadHistory : String -> sig Baseline ()
  WriteHistory : String -> sig Baseline ()

Handler Baseline IO where
  handle () (Readline p)        k = do x <- baseline p; k x ()
  handle () (AddDictEntry e)    k = do addDictEntry e; k () ()
  handle () (AddDictEntries es) k = do sequence_ (map addDictEntry es); k () ()
  handle () (ReadHistory file)  k = do readHistory file; k () ()
  handle () (WriteHistory file) k = do writeHistory file; k () ()

BASELINE : EFFECT
BASELINE = MkEff () Baseline

baseline : (prompt : String) -> Eff (Maybe String) [BASELINE]
baseline prompt = call (Readline prompt)

addDictEntry : (entry : String) -> Eff () [BASELINE]
addDictEntry entry = call (AddDictEntry entry)

addDictEntries : Traversable t => (entries : t String) -> Eff () [BASELINE]
addDictEntries entries = call (AddDictEntries entries)

readHistory : String -> Eff () [BASELINE]
readHistory file = call (ReadHistory file)

writeHistory : String -> Eff () [BASELINE]
writeHistory file = call (WriteHistory file)
