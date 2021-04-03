{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.Wai              as Wai
import qualified Network.HTTP.Types       as HTypes

main :: IO ()
main = Warp.run 8080 app

app :: Wai.Application
app req send = send $ case Wai.rawPathInfo req of
  "/" -> index
  _   -> notFound

index :: Wai.Response
index = Wai.responseFile
  HTypes.status200
  [("Content-Type", "text/html")]
  "index.html"
  Nothing

notFound :: Wai.Response
notFound = Wai.responseLBS
  HTypes.status404
  [("Content-Type", "text/plain")]
  "404 - Not Found"
