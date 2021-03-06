module Test.Data.Event where

import Prelude
import Data.Argonaut (jsonEmptyObject, (~>), (:=), (.?))
import Data.Argonaut.Encode.Class (class EncodeJson)
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Decode.Class (class DecodeJson)
import Data.Maybe (Maybe)

newtype Event = Event
  { name :: Maybe String
  }

instance decodeJsonEvent :: DecodeJson Event where
  decodeJson json = do
    obj  <- decodeJson json
    name <- obj .? "name"
    pure $ Event
      { name : name
      }

instance encodeJsonEvent :: EncodeJson Event where
  encodeJson (Event e)
    = "name" := e.name
    ~> jsonEmptyObject

instance showEvent :: Show Event where
  show (Event e) = "Event " <>
    "{ name: " <> show e.name <>
    "}"


