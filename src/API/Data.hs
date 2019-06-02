{-# LANGUAGE Arrows #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}

module API.Data where

import           Prelude hiding (sum)

import           Opaleye (Field, FieldNullable, matchNullable, isNull,
                         Table, table, tableField, selectTable,
                         Select, SelectArr, restrict, (.==), (.<=), (.&&), (.<),
                         (.===),
                         (.++), ifThenElse, sqlString, aggregate, groupBy,
                         count, avg, sum, leftJoin, runSelect,
                         showSqlForPostgres, Unpackspec,
                         SqlInt4, SqlInt8, SqlText, SqlDate, SqlFloat8, SqlBool)

import           Data.Profunctor.Product (p5)
import           Data.Profunctor.Product.Default (Default)
import           Data.Profunctor.Product.TH (makeAdaptorAndInstance)
import           Control.Arrow (returnA)

import qualified Database.PostgreSQL.Simple as PGS

import API.Types
import Control.Monad.IO.Class
import Data.Time.Calendar
import Servant


-- DB CONNECTION
dbConnectionInfo :: PGS.ConnectInfo
dbConnectionInfo = PGS.ConnectInfo "localhost" 5432 "postgres" "a" "postgres"

-- DB 'FIELDS'
type MemberField = Member'
  (Field SqlText) (Field SqlInt4) (Field SqlText) (Field SqlInt4) (Field SqlDate)

$(makeAdaptorAndInstance "pMember" ''Member')

-- TABLES
membersTable :: Table MemberField MemberField
membersTable = table "members" (pMember Member'
 { name              = tableField"name"
 , age               = tableField "age"
 , email             = tableField "email"
 , membership_number = tableField "membership_number"
 , registration_date = tableField "registration_date"})

-- QUERIES
membersSelect :: Select MemberField
membersSelect = selectTable membersTable

-- RUNNING QUERIES
members :: IO [Member]
members = PGS.connect dbConnectionInfo >>= flip runSelect membersSelect

server :: Server MemberAPI
server = liftIO members
