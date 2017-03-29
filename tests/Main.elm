port module Main exposing (..)

import GildedRoseTests
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


main : TestProgram
main =
    run emit GildedRoseTests.all


port emit : ( String, Value ) -> Cmd msg
