module Product
  ( Product,
  )
where

import GHC.Generics

data Product
  = Product
      { name :: String,
        period :: String,
        billing :: String,
        public_name :: String,
        duration :: Int
      }
  deriving (Show, Generic)
