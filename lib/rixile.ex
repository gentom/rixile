defmodule Router do
  defmacro __using__(_opts) do
    quote do
      def init(options) do
        options
      end
      def call(conn, _opts) do
        route(conn.method, conn.path_info, conn)
      end
    end
  end
end

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

  use Router
  def route("GET", ["users", user_id], conn) do
    conn |> Plug.Conn.send_resp(200, "You requested user #{user_id}")
  end
  def route(_method, _path, conn) do
    conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
  end

  require EEx # you have to require EEx before using its macros outside of functions
  EEx.function_from_file :defp, :template_show_user, "templates/show_user.eex", [:user_id]
  def route("GET", ["users", user_id], conn) do
    page_contents = template_show_user(user_id)
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
  end
  
  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    default_opts
  end

  def call(conn, _opts) do
    IO.puts "saying hello!"
    conn |> Plug.Conn.put_resp_header("Server", "Plug") |> Plug.Conn.send_resp(200, "Hello, world!")
    #conn2 = Plug.Conn.put_resp_header(conn, "Server", "Plug")
    #Plug.Conn.send_resp(conn2, 200, "Hello, world!")
  end
  """
  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end

  def route("GET", ["hello"], conn) do
    # this route is for /hello
    conn |> Plug.Conn.send_resp(200, "Hello, world!")
  end

  def route("GET", ["users", user_id], conn) do
    # this route is for /users/<user_id>
    conn |> Plug.Conn.send_resp(200, "You requested user #{user_id}")
  end

  def route(_method, _path, conn) do
    # this route is called if no other routes match
    conn |> Plug.Conn.send_resp(404, "Couldn't find that page, sorry!")
  end
  """
end
