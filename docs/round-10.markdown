# Elixir: décimo asalto (supervisores OTP)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

#### Supervisores OTP

La forma de hacer las cosas en Elixir es no preocuparse mucho por el código que falla, si no asegurarse de que la aplicación en general sigue corriendo. Suena contradictorio, pero no lo es. En Elixir los procesos son muy pequeñitos, por lo que si uno de ellos falla, casi todo el sistema sigue funcionando. Al contrario que en otros lenguajes, donde el lanzamiento de una excepción puede hacer que todo el servidor sufra. **En el mundo OTP, los supervisores son quienes monitorizan y recuperan esos procesos fallidos.**

Un supervisor en Elixir tiene un único propósito: manejar uno o más *workers* (otro tipo de procesos). La forma de funcionar es darle una lista de procesos e indicarle qué hacer con cada uno de ellos en caso de que falle. La forma más fácil de crear uno es crear un nuevo proyecto con `mix` y usar el flag `--sup`.

```
defmodule Sequence do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      worker(Sequence.Worker, [arg1, arg2, arg3])
    ]
    opts = [strategy: :one_for_one, name: Sequence.Supervisor]

    # create the supervisor with a list of workers and some options
    Supervisor.start_link(children, opts)
  end
end
```

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

- exercise-01-round-10: añade un supervisor a la aplicación anterior sobre una pila de enteros **Resultado** Increíble, increíble que sea tan fácil. Lo primero, el supervisor arranca él solito y levanta el servidor él solito también. Super cómodo. Luego, captura los errores y levanta de nuevo el servidor sin que nosotros tengamos que hacer nada más. Para hacer fallar a la pila, se podía hacer con un `Stack.Server.push -1`. El supervisor captuar el fallo, y rearranca el servidor.

## Aprender lo suficiente para hacer algo de utilidad

