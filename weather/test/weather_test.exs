defmodule WeatherTest do
  use ExUnit.Case

  def test_xml_data do
    """
      <?xml version="1.0" encoding="ISO-8859-1"?>
      <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
      <current_observation version="1.0"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
        <credit>NOAA's National Weather Service</credit>
        <credit_URL>http://weather.gov/</credit_URL>
        <image>
          <url>http://weather.gov/images/xml_logo.gif</url>
          <title>NOAA's National Weather Service</title>
          <link>http://weather.gov</link>
        </image>
        <suggested_pickup>15 minutes after the hour</suggested_pickup>
        <suggested_pickup_period>60</suggested_pickup_period>
        <location>Denton Municipal Airport, TX</location>
        <station_id>KDTO</station_id>
        <latitude>33.20505</latitude>
        <longitude>-97.20061</longitude>
        <observation_time>Last Updated on Jul 7 2015, 2:53 pm CDT</observation_time>
              <observation_time_rfc822>Tue, 07 Jul 2015 14:53:00 -0500</observation_time_rfc822>
        <weather>A Few Clouds</weather>
        <temperature_string>86.0 F (30.0 C)</temperature_string>
        <temp_f>86.0</temp_f>
        <temp_c>30.0</temp_c>
        <relative_humidity>59</relative_humidity>
        <wind_string>from the Southwest at 12.7 gusting to 23.0 MPH (11 gusting to 20 KT)</wind_string>
        <wind_dir>Southwest</wind_dir>
        <wind_degrees>210</wind_degrees>
        <wind_mph>12.7</wind_mph>
        <wind_gust_mph>23.0</wind_gust_mph>
        <wind_kt>11</wind_kt>
        <wind_gust_kt>20</wind_gust_kt>
        <pressure_string>1013.2 mb</pressure_string>
        <pressure_mb>1013.2</pressure_mb>
        <pressure_in>29.95</pressure_in>
        <dewpoint_string>70.0 F (21.1 C)</dewpoint_string>
        <dewpoint_f>70.0</dewpoint_f>
        <dewpoint_c>21.1</dewpoint_c>
        <heat_index_string>91 F (33 C)</heat_index_string>
              <heat_index_f>91</heat_index_f>
              <heat_index_c>33</heat_index_c>
        <visibility_mi>10.00</visibility_mi>
         <icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
        <two_day_history_url>http://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>
        <icon_url_name>few.png</icon_url_name>
        <ob_url>http://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>
        <disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
        <copyright_url>http://weather.gov/disclaimer.html</copyright_url>
        <privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
      </current_observation>
    """
  end

  test "parses tag from xml" do
    assert Weather.parse_tag(test_xml_data, "wind_mph") == "12.7"
    assert Weather.parse_tag(test_xml_data, "visibility_mi") == "10.00"
  end

  test "pretty prints" do
    assert Weather.pretty_print(test_xml_data, ["wind_dir", "pressure_mb", "pressure_in"]) === """
    wind_dir: Southwest
    pressure_mb: 1013.2
    pressure_in: 29.95
    """
  end

end
