defmodule Rixile do
  @moduledoc """
  Documentation for Rixile.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Rixile.hello
      :world

  """
  def hello do
    :world
  end

  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    default_opts
  end

  def call(conn, _opts) do
    IO.puts "saying hello!"
    conn |> Plug.Conn.put_resp_header("Server", "Plug") |> Plug.Conn.send_resp(200, "Hello, world!")
  end

end
