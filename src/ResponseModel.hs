module ResponseModel
  ( SubResponse,
    getSites,
  )
where

import Data.Aeson
import GHC.Generics
import Product
import RatePlan
import Zone

instance FromJSON SubResponse

instance FromJSON Res

instance FromJSON App

instance FromJSON ResultInfo

instance FromJSON Product

instance FromJSON RatePlan

instance FromJSON Zone

instance FromJSON ComponentValues

data SubResponse
  = SubResponse
      { success :: Bool,
        result :: [Res],
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

data Res
  = Res
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

getSite :: Res -> String
getSite r = getName $ zone r

getSites :: SubResponse -> [String]
getSites sr = map getSite (result sr)
