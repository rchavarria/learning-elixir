# Elixir: sexto asalto (mix, ExUnit, DocTests)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

#### Nodos - La clave para los servicios distribuidos

Un **nodo** no es más que una instancia de la máquina virtual de Erlang ejecutándose. Es como un sistema operativo completo, y ofrece servicios como tal a procesos locales o remotos.

**Nombres de nodos**

```
# En `iex`, podemos saber el nombre del nodo actual con `Node.self`
iex> Node.self

# Podemos dar un nombre al nodo al iniciar `iex`
$ iex -name foobar@localhost
iex(foobar@localhost)> Node.self
:"foobar@localhost"

# los nombres son tratados como Atoms

# podemos saber qué nodos conoce un nodo
iex(node_two)> Node.list
[]

# y al conectarnos a un nodo, aparecerá como conectado
iex(node_two)> Node.connect :"node_one@localhost"
true
iex(node_two)> Node.list
[ :"node_one@localhost" ]

# podemos ejecutar una función en un nodo remoto
iex(node_one)> func = fn -> IO.puts "Hello, I'm in #{inspect Node.self}"
iex(node_one)> Node.spawn( :"node_two@localhost", func )
Hello, I'm in :"node_two@localhost"
```

`Node.spawn` es impresionante. Podemos ejecutar una función en otro nodo fácilmente. Pero aunque se ejecute en `node_two`, hereda lo que se llama *group leader*, con lo que es capaz de mostrar mensajes por consola en `node_one` (en lugar del dos, que es donde se ejecuta)

Además de poder dar un nombre a un nodo, podemos establecer su *cookie*. La cookie de un node no es más que un token, y se utiliza para permitir que los nodos se conecten entre sí. Nodos con la misma cookie se pueden conectar. Si es distinta, los nodos rechazarán la conexión. Las cookies se mandan en texto plano, así que cuidado con las conexiones a través de internet.

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

## Aprender lo suficiente para hacer algo de utilidad

