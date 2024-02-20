# EchoServer

## Homework 02
Echo module, which recieves :ping atom as a message and returns {:pong, node()} tuple.

```elixir
iex> {:ok, pid} = EchoServer.start_link()
iex> EchoServer.echo(pid, :ping)
{:pong, :nonode@nohost}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `echo_server` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:echo_server, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/echo_server>.

