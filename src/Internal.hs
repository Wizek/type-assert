module Internal where

import ComposeLTR
import Language.Haskell.Meta
import Data.Either
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Lib
import Language.Haskell.TH.Syntax

shouldTypecheck = zeta
  $ \a -> parseExp a
    $> either
      (const [|error "shouldTypecheck"|])
      (const [|pure ()|])
shouldNotTypecheck = zeta
  $ \a -> parseExp a
    $> either
      (const $ () $ fromRight undef $ parseExp "pure ()")
      (const [|error "shouldNotTypecheck"|])

zeta kappa = QuasiQuoter
  { quoteExp  = kappa
  , quotePat  = error  "quotePat not supported"
  , quoteType = error "quoteType not supported"
  , quoteDec  = error  "quoteDec not supported"
  }
