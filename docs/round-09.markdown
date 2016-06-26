# Elixir: noveno asalto (servidores OTP)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

#### Servidores OTP

OTP (**O**pen **T**elecom **P**latform) se presenta como la solución a todos tus problemas de escalabilidad y concurrencia. No es así, pero ayuda mucho. Ayuda en temas como descubrimiento de aplicaciones, gestión y detección de fallos, actualización de código en caliente y estructura del servidor.

OTP define un sistema como una jerarquía de **aplicaciones**. Una aplicación consiste en uno o varios **procesos**. Cada uno de estos procesos implementan un **comportamiento**. Existen comportamientos para servidores, gestores de eventos, máquinas de estado finitas, ...

Lo implementado en ejercicios anteriores sigue un patrón con el que se podría implementar casi todos los servidores. Por eso, OTP proporciona un mecanismo para liberarnos de escribir el código más tedioso. La librería ofrece unas funciones a modo de *callbacks* que irá llamando dependiendo de la situación.

#### Implementar un servidor OTP

```
defmodule Sequence.Server do

  # tells Elixir that this behaviour will be used, so this module represents
  # an OTP server
  use GenServer

  # one of the callbacks provided by GenServer is handle_call. it has 3
  # parameters: action, request origin PID, current server state
  # it has to reply with a tuple with 3 parameters as well: response,
  # XXX and the state to use in the next request
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end

end


# Para llamar a este servidor, entramos en iex
promtp$ iex -S mix
# arranca el servidor, indicando el módulo y el estado inicial (similar a spawn_link)
iex> { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
iex> GenServer.call(pid, :next_number)
100
iex> GenServer.call(pid, :next_number)
101
iex> GenServer.call(pid, :next_number)
102

```

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

- exercise-01-round-09.ex: crear un server que implemente una pila. Se inicializará con unos cuantos valores en la pila. Cada petición *pop* devolverá un elemento de la pila. Cuando la pila esté vacía, fallará.

## Aprender lo suficiente para hacer algo de utilidad

