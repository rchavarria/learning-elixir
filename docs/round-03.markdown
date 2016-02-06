# Elixir: tercer asalto (Enum, Stream, Collectable y *comprehensions*)

## Aprender lo suficiente para comenzar

- Elixit tiene muchos tipos que actúan como colleciones: listas, mapas, diccionarios, rangos, ficheros e incluso funciones
- Las colecciones se pueden iterar (sobretodo con funciones del módulo `Enum`), y algunas permiten añadir elementos
- El módulo `Stream` permite enumerar collecciones de forma diferida (*lazy*)
- Procesando colleciones con `Enum`

```
# convierte cualquier colección a List
list = Enum.to_list 1..5
  #=> [1, 2, 3, 4, 5]

# concatena
Enum.concat([1, 2, 3], [4, 5, 6])
  #=> [1, 2, 3, 4, 5]

# crea nuevas colleciones
Enum.map(list, &(&1 * 10))
  #=> [10, 20, 30, 40, 50]

# selecciona elementos por posición
Enum.at(10..20, 3) #=> 13
Enum.at(10..20, 20) #=> nil
Enum.filter(list, &(&1 > 2)) #=> [3, 4, 5]
Enum.reject(list, &Integer.is_even/1) #=> [1, 3, 5]

# ordena y compara elementos
Enum.sort([ "there", "was", "a", "crooked", "man" ], 
  &(String.length(&1) <= String.length(&2))
Enum.max([ "there", "was", "a", "crooked", "man" ]) #=> "was"

# divide una colleción
Enum.take(list, 3)    #=> [1, 2, 3]
Enum.take_every(list, 2)  #=> [1, 3, 5]
Enum.take_while(list, &(&1 < 4))
Enum.split(list, 3)
  #=> { [1, 2, 3], [4, 5] }
Enum.split_while(list, &(&1 < 4))
  #=> { [1, 2, 3], [4, 5] }

# une los elementos de una colección
Enum.join(list)
Enum.join(list, ", ")   #=> "1, 2, 3, 4, 5"

# hace preguntas sobre operaciones
Enum.all?(list, &(&1 < 4))
Enum.any?(list, &(&1 < 4))
Enum.member?(list, 4)
Enum.empty?(list)

# mezcla colecciones
Enum.zip(list, [:a, :b, :c])
  #=> [ {1, :a}, {2, :b}, {3, :c} ]

# otros
Enum.reduce(<collection>, <function>)
```

**`Stream`s, enumerables diferidos/perezosos/lazies**

- Las funciones del módulo `Enum` procesan todos los elementos de la colección de una vez, consumiendo memoria. Las del módulo `Stream` consumen los elementos de uno en uno, según se van necesitando.
- Los *streams* se pueden componer, es decir, los streams son collecciones, por lo que se pueden usar las funciones de `Stream` con los propios streams.
- Para obtener los resultados, se puede convertir un `Stream` a una lista

```
[1, 2, 3, 4, 5]
  |> Stream.map(&(&1 * &1)
  |> Stream.map(&(&1 + 1)
  |> Stream.filter(fn x -> rem(x, 2) == 1 end)
  |> Enum.to_list
```

- Con `Enum` debemos esperar a tener todos los elementos de la colección para empezar a procesarlos. Con `Stream` podemos comenzar a procesarlos inmediatamente. Imagina que leemos de un servidor remoto, o de un sensor, ambos mandan datos infinitamente, por lo que `Enum` no sería una opción válida en este caso.
- Crea tus propios streams. Debemos ayudarnos de métodos proporcionados por Elixir: `cycle`, `repeatedly`, `iterate`, `unfold` y `resource`.

```
# cycle toma una coleción y va devolviendo de uno en uno indefinidamente
#cuando la colección se acaba, vuelve a empezar desde el principio
Stream.cycle([1, 2, 3])
  |> Enum.take(10)
#=> [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]

# repeatedly toma una función y la ejecuta cada vez que se le pide un elemento
Stream.repeatedly(fn -> true end) |> Enum.take(3)
  #=> [ true, true, true ]
Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)
  #=> [ 0.723, 0.941, 0.1234 ]

# iterate toma un valor inicial y una función. el primer elemento es el valor inicial,
#el siguiente es el valor devuelto por la función pasándole el valor inicial, el siguiente
#es el valor devuelto por la función pasándole el valor anterior, así indefinidamente
Stream.iterate(0, &(&1 + 1)) |> Enum.take(5)
  #=> [0, 1, 2, 3, 4]

# unfold es similar a iterate, pero con tuplas. el primer valor de la tupla
#significa el valor de la iteración actual, el segundo valor significa el valor
#a procesar en la siguiente iteración
Stream.unfold( {0, 1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end ) |> Enum.take(15)
  #=> [0, 1, 1, 2, 3, 5, 8, 13, ... fibonacci]

# resource es similar a unfold. toma tres funciones como argumentos. la primera
#crea el recurso, la segunda va dando valores de las iteraciones (como unfold)
#y la tercera cierra el recurso (fichero, bbdd, ...)
```

**El protocolo `Collectable`**

- `Enumerable` permite iterar una colección. `Collectable` permite añadir elementos a una colección
- Normalemente se utiliza `Enum.into` para hacerlo

```
Enum.into 1..5, [1000, 10001]
  #=> [1000, 1001, 1, 2, 3, 4, 5]
```

**Comprehensions**

Se le pueden pasar una o más colecciones


## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

- Darle un vistazo a fondo al módulo `Enum`, se utiliza mucho
- Implementar`all?`, `each`, `filter`, `split` y `take` (lists-and-recursion-5)
- Implementar `flatten`

## Aprender lo suficiente para hacer algo de utilidad

## Enseñar lo aprendido, y repetir desde el paso 7

