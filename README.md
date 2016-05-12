# JapanMunicipalityCode

Elixir Library for Japan municipality key converting

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  * Add japan_municipality_code to your list of dependencies in `mix.exs`:

        def deps do
          [{:japan_municipality_code, "~> 1.0.1"}]
        end

## Usage
### Converts pref code into pref name, or vice versa

```
    iex> JapanMunicipalityCode.pref(1)
    "北海道"
    iex> JapanMunicipalityCode.pref(13)
    "東京都"
    iex> JapanMunicipalityCode.pref("青森県")
    "02"
    iex> JapanMunicipalityCode.pref("東京都")
    "13"

    iex> JapanMunicipalityCode.pref(99)
    nil
    iex> JapanMunicipalityCode.pref("xxx")
    nil
    iex> JapanMunicipalityCode.pref(nil)
    nil
```

### Gets the cities with pref code or pref name

```
    iex> JapanMunicipalityCode.cities(999)
    nil
    iex> JapanMunicipalityCode.cities("xxx")
    nil
    iex> JapanMunicipalityCode.cities(nil)
    nil

    iex> (maps = [
    ...> %JapanMunicipalityCode.Cities{ code: "44201", name: "大分市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44202", name: "別府市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44203", name: "中津市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44204", name: "日田市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44205", name: "佐伯市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44206", name: "臼杵市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44207", name: "津久見市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44208", name: "竹田市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44209", name: "豊後高田市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44210", name: "杵築市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44211", name: "宇佐市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44212", name: "豊後大野市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44213", name: "由布市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44214", name: "国東市" },
    ...> %JapanMunicipalityCode.Cities{ code: "44322", name: "姫島村" },
    ...> %JapanMunicipalityCode.Cities{ code: "44341", name: "日出町" },
    ...> %JapanMunicipalityCode.Cities{ code: "44461", name: "九重町" },
    ...> %JapanMunicipalityCode.Cities{ code: "44462", name: "玖珠町" },
    ...> ]) != nil
    true
    iex> JapanMunicipalityCode.cities(44)
    maps
    iex> JapanMunicipalityCode.cities("大分県")
    maps
```


## LICENSE

This software is released under the MIT License, see LICENSE.
