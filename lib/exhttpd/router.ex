defmodule Exhttpd.Router do
  @moduledoc """
  exhttpd is intended to be a server that works as a drop-in replacement to mhttpd.

  A request to localhost:4000/CS/ serves static files
  Requests to localhost:4000/SEQ/ are proxied to mhttpd
  Requests to localhost:4000/cmd=X are handled with (1) a call to System.cmd and (2) a script that uses a command-line odbedit

  Implemented odbedit commands are start, stop, msg, jkey, jset, jcopy, and jcreate.

  """

  use Plug.Router

  plug Plug.Static, at: "/CS", from: "/home/amy/ui_dcrc_clone.git/online/"
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
    params = fetch_query_params(conn, []).params
    #%{@cmd => cmd, @odb => odbkey} = conn.params
    cmd = params["cmd"]
    odbkey = params["odb"]

    #http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/
    #odbedit response is
    #Key name                        Type    #Val  Size  Last Opn Mode Value
    #---------------------------------------------------------------------------
    #State                           INT     1     4     35h  0   RWD  1
    
    sys_cmd = "/home1/aroberts/exhttpd.git/server_scripts/get_odb.sh"
    {resp, _} = System.cmd sys_cmd, [odbkey]

    unless String.contains? resp, ["not found"] do
      [name, type, num_values, item_size, last_written, open, mode, value] 
        = resp
	|> to_string
        |> String.replace(~r/\A.+-+\W+/ms, "")
        |> String.split()

      send_resp(conn, 200, "#{name} has value #{value}")
    else 
      send_resp(conn, 200, "<DB_NO_KEY>")
    end

    #send_resp(conn, 200, "received #{resp}")
    #send_resp(conn, 200, "received #{inspect conn.params}")
    #send_resp(conn, 200, "received #{params['cmd']}, #{params['odb']}")
  end


  # everything else
  get _ do
    send_resp(conn, 404, "these are not the droids you're looking for.")
  end
end
