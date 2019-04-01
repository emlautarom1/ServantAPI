{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import           Data.Aeson
import           Data.Proxy
import           GHC.Generics
import           Network.HTTP.Client (newManager)
import           Network.HTTP.Client.TLS (tlsManagerSettings)
import           Servant.API
import           Servant.Client

import           SubscriptionModel
import           UserModel

-- Private keys:
authEmail = "emlautarom1@gmail.com"
authKey = "<INSERT-YOUR-PRIVATE-KEY>"
-- End of private keys.

type API = "user" :> "subscriptions" :> Header "X-Auth-Email" String
  :> Header "X-Auth-Key" String :> Get '[JSON] SubscriptionResponse

api :: Proxy API
api = Proxy

subscriptions :: Maybe String -> Maybe String -> ClientM SubscriptionResponse
subscriptions = client api

querySubscriptions :: ClientM SubscriptionResponse
querySubscriptions = subscriptions (Just authEmail) (Just authKey)

type API' = "user" :> Header "X-Auth-Email" String :> Header "X-Auth-Key" String
  :> ReqBody '[JSON] UserPayload :> Patch '[JSON] UserResponse

api' :: Proxy API'
api' = Proxy

user :: Maybe String -> Maybe String -> UserPayload -> ClientM UserResponse
user = client api'

patchUser :: UserPayload -> ClientM UserResponse
patchUser = user (Just authEmail) (Just authKey)

newtype UserPayload = UserPayload { zipcode :: String }
  deriving (Show, Generic)

instance ToJSON UserPayload

main :: IO ()
main = do
  putStrLn
    "Making GET request for user sites and PATCH for updating the user Zip Code..."
  manager' <- newManager tlsManagerSettings
  subMaybe <- runClientM
    querySubscriptions
    (mkClientEnv manager' (BaseUrl Http "api.cloudflare.com" 80 "client/v4"))
  case subMaybe of
    Left err   -> putStrLn $ "Error: " ++ show err
    Right subs -> print $ getSites subs
  usrMaybe <- runClientM
    (patchUser $ UserPayload "1900")
    (mkClientEnv manager' (BaseUrl Http "api.cloudflare.com" 80 "client/v4"))
  case usrMaybe of
    Left err  -> putStrLn $ "Error: " ++ show err
    Right usr -> print usr
