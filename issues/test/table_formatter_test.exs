defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF
  alias Issues.CLI, as: CLI

  def test_data do
    CLI.convert_list_of_hashdicts [
      [{"id", 123}, {"created_at", "2014-01-23T21:55:58Z"}, {"title", "OMG!"}],
      [{"id", 124}, {"created_at", "2015-01-23T21:55:58Z"}, {"title", "OMG2!"}]
    ]
  end

  test "Output is correct" do
    result = capture_io fn ->
      TF.print_table(test_data)
    end
    assert result == """
    #   | created_at           | title
    ----+----------------------+------
    123 | 2014-01-23T21:55:58Z | OMG!
    124 | 2015-01-23T21:55:58Z | OMG2!
    """
  end

end
