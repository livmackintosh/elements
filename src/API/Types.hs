{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module API.Types where

import Data.Aeson
import Data.Aeson.Types
import Data.Text
import Data.Time (UTCTime)
import Data.Time.Calendar
import Data.Time.Clock
import GHC.Generics
import Servant
import Servant.API

type MemberAPI = "members" :> Get '[JSON] [Member]

data Member = Member
  { name              :: String
  , age               :: Int
  , email             :: String
  , membership_number :: Int
  , registration_date :: Day
  } deriving (Eq, Show, Generic)

instance ToJSON Member


members :: [Member]
members =
  [ Member "Livvy Mackintosh" 22 "livvy@base.nu" 63114913000000000 (fromGregorian 2017 11 06) ]

server :: Server MemberAPI
server = return members
