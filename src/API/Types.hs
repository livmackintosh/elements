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

data Member' a b c d e = Member'
  { name              :: a
  , age               :: b 
  , email             :: c 
  , membership_number :: d
  , registration_date :: e
  } deriving (Eq, Show, Generic)

type Member = Member' String Int String Int Day

instance ToJSON Member 
