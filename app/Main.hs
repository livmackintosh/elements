module Main where

import API.Data
import API.Types
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

main :: IO ()
main = run 8081 app

app :: Application
app = serve memberAPI server

memberAPI :: Proxy MemberAPI
memberAPI = Proxy
