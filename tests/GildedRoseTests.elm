module GildedRoseTests exposing (all)

import Expect exposing (Expectation)
import GildedRose exposing (Item(Item), updateQuality)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "GildedRose.updateQuality" <|
        let
            ( quality, maxQuality, beforeSell, sellDate, afterSell ) =
                ( 5, 50, 10, 0, -10 )

            changesBy deltaSellIn deltaQuality ((Item name sellIn quality) as item) () =
                Expect.equal [ Item name (sellIn + deltaSellIn) (quality + deltaQuality) ] (updateQuality [ item ])

            {- BEWARE: the name is deceptive, as sellIn is updated implicitly.
               this seems to be well worth it regarding the readability of the tests.
            -}
            qualityChangesBy =
                changesBy -1
        in
            [ test "with several objects" <|
                \_ ->
                    Expect.equal [ Item "NORMAL ITEM" 4 9, Item "Aged Brie" 2 11 ] <|
                        updateQuality [ Item "NORMAL ITEM" 5 10, Item "Aged Brie" 3 10 ]
            , describe "with a single" <|
                [ describe "normal item" <|
                    let
                        item =
                            Item "NORMAL ITEM"
                    in
                        [ test "before sell date" <| qualityChangesBy -1 <| item beforeSell quality
                        , test "on sell date" <| qualityChangesBy -2 <| item sellDate quality
                        , test "after sell date" <| qualityChangesBy -2 <| item afterSell quality
                        , test "of zero quality" <| qualityChangesBy 0 <| item beforeSell 0
                        ]
                , describe "Aged Brie" <|
                    let
                        item =
                            Item "Aged Brie"
                    in
                        [ test "before sell date" <| qualityChangesBy 1 <| item beforeSell quality
                        , test "on sell date" <| qualityChangesBy 2 <| item sellDate quality
                        , test "after sell date" <| qualityChangesBy 2 <| item afterSell quality
                        , describe "with max quality" <|
                            [ test "before sell date" <| qualityChangesBy 0 <| item beforeSell maxQuality
                            , test "on sell date" <| qualityChangesBy 0 <| item sellDate maxQuality
                            , test "after sell date" <| qualityChangesBy 0 <| item afterSell maxQuality
                            ]
                        ]
                , describe "Sulfuras" <|
                    let
                        item =
                            flip (Item "Sulfuras, Hand of Ragnaros") <| 80
                    in
                        [ test "before sell date" <| changesBy 0 0 <| item beforeSell
                        , test "on sell date" <| changesBy 0 0 <| item sellDate
                        , test "after sell date" <| changesBy 0 0 <| item afterSell
                        ]
                , describe "Backstage Passes" <|
                    let
                        item =
                            Item "Backstage passes to a TAFKAL80ETC concert"
                    in
                        [ test "long before sell date" <| qualityChangesBy 1 <| item 11 quality
                        , test "medium close to sell date (upper bound)" <| qualityChangesBy 2 <| item 10 quality
                        , test "medium close to sell date (lower bound)" <| qualityChangesBy 2 <| item 6 quality
                        , test "very close to sell date (upper bound)" <| qualityChangesBy 3 <| item 5 quality
                        , test "very close to sell date (lower bound)" <| qualityChangesBy 3 <| item 1 quality
                        , test "on sell date" <| qualityChangesBy -quality <| item 0 quality
                        , test "after sell date" <| qualityChangesBy -quality <| item -10 quality
                        , describe "with max quality" <|
                            [ test "long before sell date" <| qualityChangesBy 0 <| item 11 maxQuality
                            , test "medium close to sell date (upper bound)" <| qualityChangesBy 0 <| item 10 maxQuality
                            , test "medium close to sell date (lower bound)" <| qualityChangesBy 0 <| item 6 maxQuality
                            , test "very close to sell date (upper bound)" <| qualityChangesBy 0 <| item 5 maxQuality
                            , test "very close to sell date (lower bound)" <| qualityChangesBy 0 <| item 1 maxQuality
                            ]
                        ]
                , describe "Conjured Item" <|
                    let
                        item =
                            Item "Conjured Item"
                    in
                        [ test "before sell date" <| qualityChangesBy -2 <| item beforeSell quality
                        , test "on sell date" <| qualityChangesBy -4 <| item sellDate quality
                        , test "after sell date" <| qualityChangesBy -4 <| item afterSell quality
                        , test "of zero quality" <| qualityChangesBy 0 <| item beforeSell 0
                        ]
                ]
            ]
