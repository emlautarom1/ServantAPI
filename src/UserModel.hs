{-# LANGUAGE DeriveGeneric #-}

module UserModel
  ( UserResponse
  , User
  ) where

import           Data.Aeson
import           GHC.Generics (Generic)

data UserResponse = UserResponse
  { success  :: Bool
  , result   :: User
  , messages :: Maybe [String]
  } deriving (Show, Generic)

data User = User
  { id                                :: String
  , email                             :: String
  , username                          :: String
  , first_name                        :: Maybe String
  , last_name                         :: Maybe String
  , telephone                         :: Maybe String
  , country                           :: Maybe String
  , zipcode                           :: Maybe String
  , two_factor_authentication_enabled :: Bool
  , two_factor_authentication_locked  :: Bool
  , created_on                        :: String
  , modified_on                       :: String
  , organizations                     :: [String]
  , has_pro_zones                     :: Bool
  , has_business_zones                :: Bool
  , has_enterprise_zones              :: Bool
  , suspended                         :: Bool
  } deriving (Show, Generic)

instance FromJSON UserResponse
instance FromJSON User
