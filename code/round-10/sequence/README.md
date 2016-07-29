# Sequence

**TODO: Add description**

## Run / Execution

This could be an example about running this application:

```
$ iex -S mix 
Compiled lib/sequence.ex
Compiled lib/sequence/server.ex
Compiled lib/sequence/stash.ex
Compiled lib/sequence/subsupervisor.ex
Compiled lib/sequence/supervisor.ex
Generated sequence.app
iex> Sequence.Server.next_number
123          
iex> Sequence.Server.next_number
124          
iex> Sequence.Server.increment_number 100
:ok          
iex> Sequence.Server.next_number
225          
iex> Sequence.Server.increment_number "cause it to crash"
:ok          
iex>         
14:35:07.337 [error] GenServer Sequence.Server terminating
Last message: {:"$gen_cast", {:increment_number, "cause it to crash"}}
State: {226, #PID<0.70.0>}
** (exit) an exception was raised:
    ** (ArithmeticError) bad argument in arithmetic expression
        (sequence) lib/sequence/server.ex:32: Sequence.Server.handle_cast/2
        (stdlib) gen_server.erl:599: :gen_server.handle_msg/5
        (stdlib) proc_lib.erl:239: :proc_lib.init_p_do_apply/3
iex> Sequence.Server.next_number
226          
iex> Sequence.Server.next_number
227  
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `sequence` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:sequence, "~> 0.1.0"}]
    end
    ```

  2. Ensure `sequence` is started before your application:

    ```elixir
    def application do
      [applications: [:sequence]]
    end
    ```

