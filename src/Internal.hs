module Internal where

import ComposeLTR
import Language.Haskell.Meta
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Lib
import Language.Haskell.TH.Syntax

-- shouldTypecheck = zeta $ \a -> parseExp a $> either (error "") "undefined"
-- shouldTypecheck = zeta $ \a -> parseExp a $> either (error "") (() [|pure ()|])
-- shouldTypecheck = zeta $ \a -> parseExp a $> either (error "") (() $ const $ pure [|pure ()|])
-- shouldNotTypecheck = zeta $ \a -> parseExp a $> either (error "") pure

shouldTypecheck = zeta
  $ \a -> parseExp a
    $> either
      (const [|error "shouldTypecheck"|])
      (const [|pure ()|])
shouldNotTypecheck = zeta
  $ \a -> parseExp a
    $> either
      (const [|pure ()|])
      (const [|error "shouldNotTypecheck"|])

zeta kappa = QuasiQuoter
  { quoteExp  = kappa
  , quotePat  = error  "quotePat not supported"
  , quoteType = error "quoteType not supported"
  , quoteDec  = error  "quoteDec not supported"
  }
