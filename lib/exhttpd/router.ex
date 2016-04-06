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
    %{"cmd" => cmd, "odb" => odbkey} = conn.params

    #http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/
    #odbedit response is
    #Key name                        Type    #Val  Size  Last Opn Mode Value
    #---------------------------------------------------------------------------
    #State                           INT     1     4     35h  0   RWD  1
    sys_cmd = "odbedit -c -l ls '#{odbkey}'"
    {resp, _} = System.cmd sys_cmd, []

    unless String.contains? resp, ["not found"] do
      [name, type, num_values, item_size, last_written, open, mode, value] 
        = resp
        |> String.replace(resp, ~r/\A.+-+\W+/ms, '')
        |> String.split()

      send_resp(conn, 200, "received #{cmd}, #{odbkey}")
    else 
      send_resp(conn, 200, "<DB_NO_KEY>")
    end

    #send_resp(conn, 200, "received #{inspect conn.params}")
    #send_resp(conn, 200, "received #{cmd}, #{odbkey}")
  end


  # everything else
  get _ do
    send_resp(conn, 404, "these are not the droids you're looking for.")
  end
end
