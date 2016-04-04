# Exhttpd

An elixir-based http server for the Midas DAQ

## Installation

Clone the exhttpd repository from github.  Then, get the dependencies and compile the application.

```
cdms_test@dcrc01 ~/packages> git clone git@github.com:pibion/exhttpd.git
cdms_test@dcrc01 ~/packages> mix do deps.get, mix compile
```

## Running the application

Often, the `exrm` package is used to create an application release.  We do not currenty use this package because it adds significant dependencies that complicate the installation process.  Instead, we use elixir to launch the application. 

Navigate to the project directory and then:

```
# start the app with iex console
cdms_test@drc01 ~/p/exhttpd> iex -S mix
iex(1)> 
```

But this probably isn't quite what you wanted!  To spawn an independent process,

```
# start the app in terminal
cdms_test@drc01 ~/p/exhttpd> mix run --no-halt
# start detached app
cdms_test@drc01 ~/p/exhttpd> elixir --detached -S mix run --no-halt
```

The exhttpd application is now running, and should respond to http requests on port 4000.

## Stopping the application

Use `ps` and `grep` to find the PID of the application, and then `kill` it.

```
amy@nightjar ~/docs.git> ps aux | grep exhttpd
amy      26595  0.6  0.6 1073092 50180 ?       Sl   14:00   0:02 /usr/lib/erlang/erts-7.3/bin/beam.smp -- -root /usr/lib/erlang -progname erl -- -home /home/amy -- -pa /usr/local/lib/elixir/bin/../lib/eex/ebin /usr/local/lib/elixir/bin/../lib/elixir/ebin /usr/local/lib/elixir/bin/../lib/ex_unit/ebin /usr/local/lib/elixir/bin/../lib/iex/ebin /usr/local/lib/elixir/bin/../lib/logger/ebin /usr/local/lib/elixir/bin/../lib/mix/ebin -elixir ansi_enabled true -noshell -s elixir start_cli -sname exhttpd -noshell -noinput -extra --sname exhttpd --detached -S mix run --no-halt
amy@nightjar ~/docs.git> kill 26595
```

