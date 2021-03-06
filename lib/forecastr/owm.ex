defmodule Forecastr.OWM do
  @moduledoc false

  @type when_to_forecast :: :today | :in_five_days
  @spec weather(when_to_forecast, String.t(), map()) :: {:ok, map()} | {:error, atom()}
  def weather(when_to_forecast, query, opts) do
    endpoint = owm_api_endpoint(when_to_forecast)
    fetch_weather_information(endpoint <> "?q=#{query}", opts)
  end

  @spec fetch_weather_information(binary(), map()) :: {:ok, map()} | {:error, atom()}
  def fetch_weather_information(endpoint, opts) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           Forecastr.HTTP.get(endpoint, [], params: opts) do
      {:ok, Poison.decode!(body)}
    else
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Response{status_code: 401}} ->
        {:error, :api_key_invalid}

      error = {:error, _reason} ->
        error
    end
  end

  @spec owm_api_endpoint(when_to_forecast) :: String.t()
  def owm_api_endpoint(:today), do: "api.openweathermap.org/data/2.5/weather"
  def owm_api_endpoint(:in_five_days), do: "api.openweathermap.org/data/2.5/forecast"
end
