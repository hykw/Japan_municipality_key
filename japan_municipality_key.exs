defmodule JpMunicipality do

  defmodule Cities do
    defstruct code: nil, name: nil
    @type t :: %__MODULE__{
      code: String.t, name: String.t
    }
  end


  file_pref = Path.join([__DIR__, "resources", "prefs.tsv"])
  file_cities = Path.join([__DIR__, "resources", "cities.tsv"])


  ### pref
  for line <- File.stream!(file_pref, [], :line) do
    [pref | tail] = line
                          |> String.strip()
                          |> String.split("\t")

    [pref_code | _ ] = tail

    def pref(unquote(pref)), do: unquote(pref_code)
    def pref(unquote(String.to_integer(pref_code))), do: unquote(pref)
  end

  def pref(_), do: nil


  ### cities
  for line <- File.stream!(file_cities, [], :line) do
    pref_code = String.slice(line, 0, 2)

    cities = line
              |> String.strip()
              |> String.split("\t")

    defp cities_array(unquote(String.to_integer(pref_code))), do: unquote(cities)
  end

  defp cities_array(_), do: nil


  def cities(nil), do: nil

  def cities(pref_code) when is_number(pref_code) do
    cities_array = cities_array(pref_code)

    case cities_array do
      nil -> nil
      _ ->
        Enum.map(cities_array, fn(x) ->
          [code, _pref, city] = x
                                |> String.split(",")
          %JpMunicipality.Cities{ code: code, name: city}
        end)
    end
  end

  def cities(pref) do
    pref_code = pref(pref)

    case pref_code do
      nil -> nil
      _ ->
        cities(String.to_integer(pref_code))
    end
  end
end

