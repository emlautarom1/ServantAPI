module Zone
  ( Zone,
    getName,
  )
where

import GHC.Generics

data Zone
  = Zone
      { id :: String,
        name :: String
      }
  deriving (Show, Generic)

getName :: Zone -> String
getName = name
