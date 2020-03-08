module RatePlan
  ( RatePlan,
  )
where

import GHC.Generics

data RatePlan
  = RatePlan
      { id :: String,
        public_name :: String,
        currency :: String,
        scope :: String,
        externally_managed :: Bool,
        sets :: [String],
        is_contract :: Bool
      }
  deriving (Show, Generic)
