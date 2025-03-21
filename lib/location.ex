NimbleCSV.define(PostCodeCSV, separator: ",", escape: "\~")
NimbleCSV.define(LocationCSV, separator: "\t", escape: "\~")

defmodule Location do
  require Logger
  defdelegate get_country(alpha_2), to: Location.Country
  defdelegate search_country(alpha_2), to: Location.Country
  defdelegate get_subdivision(code), to: Location.Subdivision
  defdelegate search_subdivision(code), to: Location.Subdivision
  defdelegate get_city(code), to: Location.City
  defdelegate get_city(city_name, country_code), to: Location.City
  defdelegate get_postal_code(code), to: Location.PostalCode
  defdelegate get_postal_codes(country_code, state_code, city_name), to: Location.PostalCode
  defdelegate get_postal_codes(), to: Location.PostalCode

  def unload_all()do
    :ok = unload(Location.Country)
    :ok = unload(Location.Subdivision)
    :ok = unload(Location.City)
    :ok = unload(Location.PostalCode)
  end

  def load_all() do
    Logger.debug("Loading location databases...")

    :ok = load(Location.Country)
    :ok = load(Location.Subdivision)
    :ok = load(Location.City)
    :ok = load(Location.PostalCode)
  end

  def load(module) do
    {t, _result} =
      :timer.tc(fn ->
        module.load()
      end)

    time = t / 1_000_000

    Logger.debug("Loading location database #{inspect(module)} took: #{time}s")
    :ok
  end

  def unload(module) do
    module.unload()

    Logger.debug("Unloading location database #{inspect(module)}")
    :ok
  end

  def version() do
    version_file = Application.app_dir(:location, "priv/version")

    File.read!(version_file)
  end
end
