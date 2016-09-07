# Elixir: duodécimo asalto (tareas y agentes, Tasks y Agents)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

#### Tasks y Agents

Las dos últimas abstracciones de Elixir que vamos a estudiar son los Tasks y los Agents. Estos no son de tan bajo nivel como las primitivas que vimos en la

ronda XXX

(`spawn`, `send` y `receive`) y tampoco son tan pesados como OTP. Son un punto intermedio. Utilizan funcionalidades de OTP, pero nos aíslan de muchos detalles, lo que hace que trabajar con procesos y procesos distribuidos sea muchísimo más fácil.

#### Task

Una tarea (*Task*) es una función que se ejecuta en *background*. Existen dos funciones principales: `async` y `await` y su forma de usarla sería la siguiente:

```
# ...
# Realizar una computación que tarde mucho tiempo
worker = Task.async(fn -> Fibonacci.of(200000) end)
# ...
result = Task.await(worker)
# ...
```

`async` crea un proceso separado que ejecuta la función. Devuelve un descriptor del proceso (o *worker*). `await` espera a que el proceso termine para recuperar el valor devuelto por la función. En lugar de pasar una función, también podemos pasar el nombre de un módulo, función y parámetros: `Task.async(Fibonacci, :of, [ 200000 ])`.

Las Tasks están implementadas como servidores OTP, por lo que podemos incluirlas en nuestro árbol de supervisión de aplicaciones. Existen dos formas:

1. Pasando la función a ejecutar a `Task.start_link` en lugar de llamar a `Task.async` desde un proceso que ya esté supervisado
2. Creando un worker desde un supervisor:

```
import Supervisor.Spec
children = [
  worker(Task, [ fn -> do_something_extraordinary() end ])
]
supervise children, strategy: :one_for_one
```

#### Agent

Un Agent es un proceso en background que mantiene un estado. El estado puede ser accedido desde un proceso, un nodo o múltiples nodos.

El estado inicial se toma desde una función que se le pasa a la hora de arrancar el Agent.

Se utiliza `Agent.get` para obtener el estado. Hay que pasarle una función, cuyo parámetro será el estado actual del Agent. El valor devuelto por `Agent.get` es el valor devuelto por la función.

Se utiliza `Agent.update` para modificar el estado. También hay que pasar una función. El valor devuelto por la función será el nuevo estado.

```
# count es el descriptor del Agent
iex> { :ok, count } = Agent.start(fn -> 0 end)
{:ok, #PID<0.69.0>}
iex> Agent.get(count, &(&1))
0            
# incrementa el en uno el estado
iex> Agent.update(count, &(&1+1))
:ok          
iex> Agent.update(count, &(&1+1))
:ok          
# obtiene el estado actual
iex> Agent.get(count, &(&1))
2
```

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

## Aprender lo suficiente para hacer algo de utilidad

