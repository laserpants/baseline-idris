module Effect.Baseline

import Effects
import Baseline

%access public export

data Baseline : Effect where
  Read : String -> sig Baseline (Maybe String)
  AddDictEntry : String -> sig Baseline ()
  AddDictEntries : Traversable t => t String -> sig Baseline ()

Handler Baseline IO where
  handle () (Read p)            k = do x <- baseline p; k x ()
  handle () (AddDictEntry e)    k = do addDictEntry e; k () ()
  handle () (AddDictEntries es) k = do sequence_ (map addDictEntry es); k () ()

BASELINE : EFFECT
BASELINE = MkEff () Baseline

baseline : String -> Eff (Maybe String) [BASELINE]
baseline prompt = call (Read prompt)

addDictEntry : String -> Eff () [BASELINE]
addDictEntry entry = call (AddDictEntry entry)

addDictEntries : Traversable t => t String -> Eff () [BASELINE]
addDictEntries entries = call (AddDictEntries entries)
