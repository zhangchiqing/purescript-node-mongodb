module Examples.Database.Mongo.Find where

import Database.Mongo.Mongo
import Database.Mongo.ConnectionInfo
import Database.Mongo.Bson.BsonValue

import Control.Monad.Aff
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Exception

import Data.Argonaut (printJson)
import Data.Argonaut.Core (Json(..))
import Data.Argonaut.Decode (DecodeJson, decodeJson)
import Data.Either
import Data.Event
import Data.Maybe
import Data.String.Regex

import Debug.Trace

foreign import traceAny
  """
  function traceAny(a){
    return function () {
      console.log(a);
      return {};
    };
  }
  """ :: forall e a. a -> Eff (trace :: Trace | e) Unit

main = launchAff $ do
  
  Right database <- attempt $ connect $ defaultOptions { db = Just "events" }
  col <- collection "events" database
  cur <- find [ "name" := "Wow!" ] [ "name" := 1 ] col
  res <- collect cur

  liftEff $ traceAny (res :: [Event])
  
  close database