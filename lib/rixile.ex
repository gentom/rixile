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
    IO.puts "starting up Rixile..."
    default_opts
  end

  '''
  def call(conn, _opts) do
    IO.puts "Calling Rixile call"
    Plug.Conn.send_resp(conn, 200, "Hello Rixile :)")
  end
  '''

  def call(conn, _opts) do
    IO.puts "Calling Rixile call"
    # `A() |> B() |> C()` means `C(B(A))`
    conn |> Plug.Conn.put_resp_header("Server", "Plug") |> Plug.Conn.send_resp(200, "Hello Rixile :)")
    # you can rewrite the line above
    '''
    conn2 = Plug.Conn.put_resp_header(conn, "Server", "Plug")
    Plug.Conn.send_resp(conn2, 200, "Hello Rixile :)")
    '''
  end

end
