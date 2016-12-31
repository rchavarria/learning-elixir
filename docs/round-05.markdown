# Elixir: control de flujo (condicionales,...)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

En esta quinta ronda, toca estudiar control de flujo: condicionales,...

En Elixir no se usan mucho, se suelen escribir métodos pequeños, que junto con claúsulas de guarda y *pattern matching* nos alejan bastante de lo que aquí estudiaremos.

**`if` y `unless`**

```
# Ambos toman dos parámetros, una condición y una *keyword list*, cuyas claves posibles son `do:` y `else:`.
if 1 == 2, do: "truthy", else: "falsy"
unless 2 == 1, do: "do not execute", else: "execute this"

# igual que las funciones, se puede acortar un poco
if 1 == 2 do
  "truthy"
else
  "falsy"
end
```

**`cond`**

Es una macro, que acepta una serie de condiciones. Se ejecutará el código cuyas condiciones se evalúen a `true`.

```
# Resolver la kata FizzBuzz
cond do
  rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
  rem(current, 5) == 0 -> "Buzz"
  rem(current, 3) == 0 -> "Fizz"
  true -> current
end
```

En muchos casos, una mejor alternativa puede ser utilizar múltiples funciones, pattern matching y claúsulas de guarda en lugar del bloque `cond`.

**`case`**

`case` permite evaluar una serie de patrones, y ejecuta el código asociado a dicho patrón. También se pueden usar claúsulas de guarda.

```
# para controlar errores al abrir un fichero
case File.ope("some file.txt") do
  { :ok, file } -> IO.puts "First line: #{IO.read(file, :line)}"
  { :error, reason } -> IO.puts "Failed to open file: #{reason}"
end

# con claúsulas de guarda
dave = %{name: "Dave", age: 27}
case dave do
  person = %{age: age} when is_number(age) and age >= 21 -> IO.puts "You are allowed #{person.name}"
  _ -> IO.puts "You are not allowed"
end
```

**Excepciones**

Las excepciones en Elixir se usan para casos excepcionales. Por ejemplo, si hay un fallo al leer un fichero de configuración, con un nombre fijo. Pero no si hay un error al leer un fichero que el usuario ha introducido el nombre, podemos controlar eso, y no sería un error excepcional.

```
# lanzando una RuntimeError
raise "Giving up"

# o con algunos argumentos
raise RuntimeError, message: "Stack overflow"

# por convención, se puede escribir ! al final de una llamada que puede devolver una excepción bien conocida, por ejemplo
{ ok: file } = File.open!("foo.bar")
```

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

## Aprender lo suficiente para hacer algo de utilidad

- exercise-01-round-05.exs: reescribe la kata FizzBuzz con `case`
- exercise-02-round-05.exs: muchas funciones tienen una segunda implementación, que termina con `!`, la cual, si el resultado no coincide con `{ :ok, data }` lanza una excepción. Implementa una función `ok!` que haga exactamente esto

## Enseñar lo aprendido, y repetir desde el paso 7

