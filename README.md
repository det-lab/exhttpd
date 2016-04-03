# Exhttpd

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add exhttpd to your list of dependencies in `mix.exs`:

        def deps do
          [{:exhttpd, "~> 0.0.1"}]
        end

  2. Ensure exhttpd is started before your application:

        def application do
          [applications: [:exhttpd]]
        end

## Running with an elixir prompt

To start the Application with an attached elixir interpreter, navigate to the project directory and then:

```
amy@nightjar ~/w/server> iex -S mix
iex(1)> 
```

## Running from the command line

You can compile this applicatin with the elixir release manager exrm.  Within the project directory, do:

```
$ mix do deps.get, mix compile
$ mix release
```

This will create a `rel` directory with an executable named `exhttpd`.  Start the server with

```
$ ./rel/exhttpd/bin/exhttpd start
$ ./rel/exhttpd/bin/exhttpd ping
$ ./rel/exhttpd/bin/exhttpd remote_console
```
