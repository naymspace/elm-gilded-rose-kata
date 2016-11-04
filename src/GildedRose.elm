module GildedRose exposing (Item(Item), updateQuality)


type alias GildedRose =
    List Item


type Item
    = Item String Int Int


updateQuality : GildedRose -> GildedRose
updateQuality =
    List.map updateQualityItem


updateQualityItem (Item name sellIn quality) =
    let
        {- BEWARE: the name is deceptive, as sellIn is updated implicitly. seems to be well worth it regarding readability. -}
        changeQualityBy =
            (+) quality >> clamp 0 50 >> Item name (sellIn - 1)
    in
        case name of
            "Aged Brie" ->
                if sellIn > 0 then
                    changeQualityBy 1
                else
                    changeQualityBy 2

            "Backstage passes to a TAFKAL80ETC concert" ->
                if sellIn > 10 then
                    changeQualityBy 1
                else if sellIn > 5 then
                    changeQualityBy 2
                else if sellIn > 0 then
                    changeQualityBy 3
                else
                    changeQualityBy -quality

            "Sulfuras, Hand of Ragnaros" ->
                Item name sellIn quality

            "Conjured Item" ->
                if sellIn > 0 then
                    changeQualityBy -2
                else
                    changeQualityBy -4

            _ ->
                if sellIn > 0 then
                    changeQualityBy -1
                else
                    changeQualityBy -2
