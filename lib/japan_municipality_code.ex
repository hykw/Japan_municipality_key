defmodule JapanMunicipalityCode do
  @moduledoc """
  Elixir Library for Japan municipality key converting
  """

  defmodule Cities do
    @moduledoc """
    the struct for cities info
    """

    defstruct code: nil, name: nil

    @type t :: %__MODULE__{
            code: String.t(),
            name: String.t()
          }
  end

  file_pref = Path.join([__DIR__, "..", "priv", "prefs.tsv"])
  file_cities = Path.join([__DIR__, "..", "priv", "cities.tsv"])

  @external_resource file_pref
  @external_resource file_cities

  ### pref
  for line <- File.stream!(file_pref, [], :line) do
    [pref | tail] =
      line
      |> String.strip()
      |> String.split("\t")

    [pref_code | _] = tail

    @spec pref(String.t()) :: String.t()
    def pref(unquote(pref)), do: unquote(pref_code)

    @spec pref(integer) :: String.t()
    def pref(unquote(String.to_integer(pref_code))), do: unquote(pref)
  end

  @doc ~S"""
  Converts pref code into pref name, or vice versa.

  ## Examples

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

  """
  @spec pref(any) :: nil
  def pref(_), do: nil

  ### cities
  for line <- File.stream!(file_cities, [], :line) do
    pref_code = String.slice(line, 0, 2)

    cities =
      line
      |> String.strip()
      |> String.split("\t")

    defp cities_array(unquote(String.to_integer(pref_code))), do: unquote(cities)
  end

  defp cities_array(_), do: nil

  @doc ~S"""
  Gets the cities with pref code or pref name.

  ## Examples

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

  """
  @spec cities(nil) :: nil
  def cities(nil), do: nil

  @spec cities(integer) :: any
  def cities(pref_code) when is_number(pref_code) do
    cities_array = cities_array(pref_code)

    case cities_array do
      nil ->
        nil

      _ ->
        Enum.map(cities_array, fn x ->
          [code, _pref, city] =
            x
            |> String.split(",")

          %JapanMunicipalityCode.Cities{code: code, name: city}
        end)
    end
  end

  @spec cities(String.t()) :: any
  def cities(pref) do
    pref_code = pref(pref)

    case pref_code do
      nil ->
        nil

      _ ->
        cities(String.to_integer(pref_code))
    end
  end
end
