port module Main exposing (..)

import GildedRoseTests
import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)


main : Program Value
main =
    run emit GildedRoseTests.all


port emit : ( String, Value ) -> Cmd msg
