# Elixir: cuarto asalto (Binarios, Cadenas)

## Aprender lo suficiente para comenzar

- Las cadenas pueden usar comillas simples o comillas dobles
- Acepta `heredocs`, con comillas triples
- **Sigils** (código, señal, símbolo mágico). Comienzan con `~`, seguido de una letra que determina el tipo de símbolo (`c` para una lista de carácteres, `r` para expresión regular, `w` para una lista de palabras separado por espacios,...) y cuyo valor se puede enmarcar en distintos delimitadores: `<..>`, `{...}`, `[...]`,...
- Cadenas con comillas dobles, son realmente *strings* en Elixir. Cadenas con comillas simples, se llaman *character lists* (o *char list*)

**Cadenas con comillas simples**

Son una lista de código que representan los caracteres. Y como son una lista, podemos usar métodos de `List`: `++`, `--`, `List.zip`, `[ head | tail ]`,...

Para saber el número entero que representa un carácter, se puede usar la notación `?<chr>`, por ejemplo, `?a` o `?4`, para saber los valores numéricos de `a` y `4` respectivamente.

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

## Aprender lo suficiente para hacer algo de utilidad

- exercise-01-round-04.exs: escribe una función que devuelva `true` si el parámetro (una lista de carácteres) contiene sólo carácteres imprimibles (del espacio a la tilde)

## Enseñar lo aprendido, y repetir desde el paso 7

