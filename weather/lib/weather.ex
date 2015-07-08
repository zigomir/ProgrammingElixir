defmodule Weather do

  require Logger

  def fetch do
    HTTPoison.get!("http://w1.weather.gov/xml/current_obs/KDTO.xml")
    |> handle_response
    |> pretty_print(["wind_dir", "pressure_mb", "pressure_in"])
    |> IO.puts
  end

  def handle_response(%HTTPoison.Response{status_code: 200, body: body}) do
    Logger.info "Successful response"
    body
  end
  def handle_response(%HTTPoison.Response{status_code: status}) do
    Logger.error "Error #{status} returned"
    {:error}
  end

  def parse_tag(xml, tag_name) do
    {:ok, regex_expr} = Regex.compile("<#{tag_name}>(.+?)</#{tag_name}>")
    [_, res]          = Regex.run(regex_expr, xml)
    res
  end

  def pretty_print(xml, []), do: ""
  def pretty_print(xml, [ attribute | rest ]) do
    "#{attribute}: #{parse_tag(xml, attribute)}\n" <> pretty_print(xml, rest)
  end

end
