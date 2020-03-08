module SubscriptionModel
  ( SubscriptionResponse,
    getSites,
  )
where

import Data.Aeson
import GHC.Generics
import Product
import RatePlan
import Zone

instance FromJSON SubscriptionResponse

instance FromJSON Subscription

instance FromJSON App

instance FromJSON ResultInfo

instance FromJSON Product

instance FromJSON RatePlan

instance FromJSON Zone

instance FromJSON ComponentValues

data SubscriptionResponse
  = SubscriptionResponse
      { success :: Bool,
        result :: [Subscription],
        result_info :: ResultInfo,
        messages :: Maybe [String],
        api_version :: String
      }
  deriving (Show, Generic)

newtype ResultInfo
  = ResultInfo
      { next_page :: Bool
      }
  deriving (Show, Generic)

data Subscription
  = Subscription
      { id :: String,
        product :: Product,
        rate_plan :: RatePlan,
        component_values :: [ComponentValues],
        zone :: Zone,
        frequency :: String,
        currency :: String,
        app :: App
      }
  deriving (Show, Generic)

newtype App
  = App
      { install_id :: Maybe String
      }
  deriving (Show, Generic)

data ComponentValues
  = ComponentValues
      { name :: String,
        value :: Int,
        price :: Int
      }
  deriving (Show, Generic)

getSites :: SubscriptionResponse -> [String]
getSites sr = map (getName . zone) (result sr)
