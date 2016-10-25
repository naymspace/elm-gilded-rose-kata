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
        quality' =
            if (name /= "Aged Brie" && name /= "Backstage passes to a TAFKAL80ETC concert") then
                if quality > 0 then
                    if name /= "Sulfuras, Hand of Ragnaros" then
                        quality - 1
                    else
                        quality
                else
                    quality
            else if quality < 50 then
                quality
                    + 1
                    + (if name == "Backstage passes to a TAFKAL80ETC concert" then
                        if sellIn < 11 then
                            if quality < 49 then
                                1
                                    + (if sellIn < 6 then
                                        if quality < 48 then
                                            1
                                        else
                                            0
                                       else
                                        0
                                      )
                            else
                                0
                        else
                            0
                       else
                        0
                      )
            else
                quality

        sellIn' =
            if name /= "Sulfuras, Hand of Ragnaros" then
                sellIn - 1
            else
                sellIn
    in
        if sellIn' < 0 then
            if name /= "Aged Brie" then
                if name /= "Backstage passes to a TAFKAL80ETC concert" then
                    if quality' > 0 then
                        if name /= "Sulfuras, Hand of Ragnaros" then
                            (Item name sellIn' (quality' - 1))
                        else
                            (Item name sellIn' quality')
                    else
                        (Item name sellIn' quality')
                else
                    (Item name sellIn' (quality' - quality'))
            else if quality' < 50 then
                (Item name sellIn' (quality' + 1))
            else
                (Item name sellIn' quality')
        else
            (Item name sellIn' quality')
