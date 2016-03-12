# Elixir: cuarto asalto (Binarios, Cadenas)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

- Las cadenas pueden usar comillas simples o comillas dobles
- Acepta `heredocs`, con comillas triples
- **Sigils** (código, señal, símbolo mágico). Comienzan con `~`, seguido de una letra que determina el tipo de símbolo (`c` para una lista de carácteres, `r` para expresión regular, `w` para una lista de palabras separado por espacios,...) y cuyo valor se puede enmarcar en distintos delimitadores: `<..>`, `{...}`, `[...]`,...
- Cadenas con comillas dobles, son realmente *strings* en Elixir. Cadenas con comillas simples, se llaman *character lists* (o *char list*)

**Cadenas con comillas simples**

Son una lista de código que representan los caracteres. Y como son una lista, podemos usar métodos de `List`: `++`, `--`, `List.zip`, `[ head | tail ]`,...

Para saber el número entero que representa un carácter, se puede usar la notación `?<chr>`, por ejemplo, `?a` o `?4`, para saber los valores numéricos de `a` y `4` respectivamente.

**Binarios**

El tipo *binario* representa una secuencia de bits

```
iex> b = << 1, 2, 3 >>
<<1, 2, 3>>
iex> byte_size b
3
iex> bit_size b
24

# se puede especificar también la cantidad de bits que queremos que ocupen
iex> b = << 1::size(2), 1::size(3) >>
<<9::size(5)>>
iex> byte_size b
1
iex> bit_size b
5

# también se pueden almacenar enteros, floats y otros binarios
iex> an_int = << 1 >>
<<1>>
iex> a_float = << 2.5 :: float >>
<<64, 4, 0, 0, 0, 0, 0, 0>>
iex> mix = << an_int :: binary, a_float :: binary >>
<<1, 64, 4, 0,......>>

# extraer valores (echa un vistazo a cómo se codifican los floats según el estándar IEEE 754
iex> << sign::size(1), exp::size(11), mantissa::size(52) >> = << 3.14159::float >>
iex> (1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exp-1023)
3.14159

# las cadenas con comillas dobles "" son de tipo binario, y están codificadas en UTF-8
# lo que significa que la longitud de la cadena no tiene porqué coincidir con el tamaño en bytes
iex> dqs = "∂x/∂y"
"∂x/∂y"
iex> String.length dqs
5
iex> byte_size dqs
9
```

**Procesando cadenas**

Igual que podemos dividir una lista en `head` y `tail`, podemos extraer el primer carácter (o grafema/grafo/...) de una cadena binaria o dqs (double quoted string) especificando que `head` es de tipo `utf8` y que `tail` sigue siendo de tipo binario:

```
defp _each(<< head::utf8, tail::binary >>), do [ head | _each(tail) ]
defp _each(<<>>), do []
```

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

- Ver documentación del módulo `String`, que contiene métodos para manipular cadenas encerradas en comillas dobles (recuerda, son de tipo binario).

## Aprender lo suficiente para hacer algo de utilidad

- exercise-01-round-04.exs: escribe una función que devuelva `true` si el parámetro (una lista de carácteres) contiene sólo carácteres imprimibles (del espacio a la tilde)
- exercise-02-round-04.exs: escribe una función que devuelva `true` en el caso de que dos palabras sean anagramas. `anagram?(word1, word2)`
- exercise-03-round-04.exs: escribe una funcion que calcule suma, resta,... de una cadena pasada como parámetro: `calculate('123 + 27') # => 150`. Este es especialmente difícil (al menos para mi nivel): devolver tuplas, parsear números (utilizando recursión de una forma muy imaginativa), utilizando pattern matching para construir funciones dependiendo del operador,...
- exercise-04-round-04.exs: escribe una función que pasándole una lista de dqs (double quoted strings) las imprima centradas en un ancho de la palabra más larga, cada una en una línea distinta.
- exercise-05-round-04.exs: escribe una función que pase a mayúsculas la primera letra de cada frase en una cadena
- exercise-06-round-04.exs: escribe una función que parsee un fichero CSV (que tendrá los campos id, estado y cantidad neta), y que se lo pase a la función desarrollada en la ronda anterior (exercise-02-round-03.exs).

## Enseñar lo aprendido, y repetir desde el paso 7

