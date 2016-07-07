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
  # value returned and the state to use in the next request
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

#### Servidores que no tienen que devolver un resultado

En ocasiones no necesitamos que el servidor retorne un resultado. En estos casos, para llamar al servidor emplearemos `GenServer.cast`, y para manejar esas peticiones, nuestro servidor debe implementar el callback `handle_cast`.

#### Callbacks de GenServer

GenServer es un protocolo de OTP. OTP asume que este protocolo define 6 callbacks. Elixir proporciona una implementación por defecto para cada uno de ellos en GenServer, por eso no tenemos que implementarlos nosotros. Los 6 callbacks son: `init(start_arguments)`, `handle_call(request, from, state)`, `handle_cast(request, state)`, `handle_info(info, state)`, `terminate(reason, state)`, `code_change(from_version, state, extra)` y `format_status(reason, [ pdict, state ])`.

#### Nombrado de procesos

En lugar de usar el PID para referenciar a procesos de nuestro servidor, podemos hacerlo a través de nombres. Para ello, se debe utilizar la opción `name:` a la hora de crear el servidor:

```
iex> { :ok, pid } = GenServer.start_link(Sequence.Server, 100, name: :seq)
iex> GenServer.call(:seq, :next_number)
100
iex> GenServer.call(:seq, :next_number)
101
iex> GenServer.call(:seq, :next_number)
102
iex> :sys.get_status :seq
```

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

- exercise-01-round-09: crear un server que implemente una pila. Se inicializará con unos cuantos valores en la pila. Cada petición *pop* devolverá un elemento de la pila. Cuando la pila esté vacía, fallará. Implementado en `code/round-09/stack`.
- exercise-02-round-09: ampliar el servidor anterior, de forma que se puedan añadir elementos a la pila con la operación `:push` a través de peticiones *cast*. Implementado en `code/round-09/stack2`
- exercise-03-round-09: dar un nombre al servidor anterior, de forma que se le pueda llamar sin necesidad de saber el PID. También, crear un API en la pila de forma que los clientes no tengan que llamar a `GenServer` para usarla. Simplemente serán unas funciones que envolverán las llamadas a `GenServer`.
- exercise-04-round-09: implementar el callback `GenServer.terminate/2` para comprobar distintas formas de terminar el servidor: un callback lanza una excepción, se llama a `Kernel.exit/1`, se detecta que un proceso ha tenido un error,... **Resultado** No he obtenido nada en claro. Tendría que profundizar en la documentación the [`GenServer.terminate/2`](http://elixir-lang.org/docs/stable/elixir/GenServer.html#c:terminate/2), que parece bastante espesa por cierto. Pero no está garantizado que se llame a `terminate`, con lo que no sé si estoy provocando correctamente los errores

## Aprender lo suficiente para hacer algo de utilidad

