ExUnit.start
Code.require_file("japan_municipality_key.exs")

defmodule JpMunicipalityTest do
  use ExUnit.Case, async: true
  import JpMunicipality


  test "Ensure loaded?" do
    assert Code.ensure_loaded?(JpMunicipality)
  end


  test "test pref" do
    assert JpMunicipality.pref(1) == "北海道"
    assert JpMunicipality.pref(13) == "東京都"

    assert JpMunicipality.pref("青森県") == "02"
    assert JpMunicipality.pref("東京都") == "13"

    assert JpMunicipality.pref(99) == nil
    assert JpMunicipality.pref("xxx") == nil
    assert JpMunicipality.pref(nil) == nil
  end


  test "test cities" do
    maps = [
      %JpMunicipality.Cities{ code: "44201", name: "大分市" },
      %JpMunicipality.Cities{ code: "44202", name: "別府市" },
      %JpMunicipality.Cities{ code: "44203", name: "中津市" },
      %JpMunicipality.Cities{ code: "44204", name: "日田市" },
      %JpMunicipality.Cities{ code: "44205", name: "佐伯市" },
      %JpMunicipality.Cities{ code: "44206", name: "臼杵市" },
      %JpMunicipality.Cities{ code: "44207", name: "津久見市" },
      %JpMunicipality.Cities{ code: "44208", name: "竹田市" },
      %JpMunicipality.Cities{ code: "44209", name: "豊後高田市" },
      %JpMunicipality.Cities{ code: "44210", name: "杵築市" },
      %JpMunicipality.Cities{ code: "44211", name: "宇佐市" },
      %JpMunicipality.Cities{ code: "44212", name: "豊後大野市" },
      %JpMunicipality.Cities{ code: "44213", name: "由布市" },
      %JpMunicipality.Cities{ code: "44214", name: "国東市" },
      %JpMunicipality.Cities{ code: "44322", name: "姫島村" },
      %JpMunicipality.Cities{ code: "44341", name: "日出町" },
      %JpMunicipality.Cities{ code: "44461", name: "九重町" },
      %JpMunicipality.Cities{ code: "44462", name: "玖珠町" },
    ]
    assert JpMunicipality.cities(44) == maps
    assert JpMunicipality.cities("大分県") == maps

    assert JpMunicipality.cities(999) == nil
    assert JpMunicipality.cities("xxx") == nil
    assert JpMunicipality.cities(nil) == nil
  end

end
