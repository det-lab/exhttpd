defmodule Exhttpd.Router do
  use Plug.Router

  plug Plug.Static, at: "/static", from: "/home/amy/ui_dcrc_clone.git/online/"
  plug :match
  plug :dispatch

  # about path
  get "/about" do
    send_resp(conn, 200, "This entire website runs on Elixir plugs!")
  end

  # external resource
  get "/home" do
    resp = HTTPoison.get! "google.com"
    send_resp(conn, 200, resp.body)
  end

  # get result of system command
  get "/ls" do
    {resp, _} = System.cmd "ls", []
    send_resp(conn, 200, resp)
  end

  get "/" do
    conn = fetch_query_params(conn, [])
    #send_resp(conn, 200, "received #{inspect conn.params}")
    send_resp(conn, 200, "received #{conn.params["cmd"]}, #{conn.params["val"]}")
  end


  # everything else
  get _ do
    send_resp(conn, 404, "these are not the droids you're looking for.")
  end
end
