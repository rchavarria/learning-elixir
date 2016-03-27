# Elixir: sexto asalto (mix, ExUnit, DocTests)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

Elixir viene con la herramienta `mix`, la herramienta oficial de construcción de proyectos (creación, testeo, construcción, gestión de dependencias,...). En este asalto crearemos una aplicación que nos permitirá listar los últimos `n` *issues* de cualquier proyecto de GitHub.

`mix help` lista los comandos disponibles. Los más interesantes podrían ser: `mix run` para ejecutar el proyecto, `mix test` para ejecutar los tests o `mix new` para crear uno nuevo.

Crearemos un nuevo proyecto, llamado `rct_issues`:

  $ mix new rct_issues

Listando los ficheros y directorios que ha creado el comando, encontramos los siguientes:

- `/README.md`: aquí podemos poner la descripción del proyecto. [GitHub] ha traído de vuelta la popularidad de este fichero en la raiz de los proyectos.
- `/config/`: donde vivirá la configuración del proyecto
- `/lib/`: aquí irá el código fuente de nuestro proyecto
- `mix.exs`: opciones de configuración del proyecto en sí
- `/test/`: aquí irá el código de tests

**Transformación: parsear la línea de comandos**

En Elixir existen una serie de convenciones:

- El código que gestiona la línea de comandos va en un módulo llamado `<proyecto>.CLI`, así que nuestro código iría en un módulo llamado `RctIssues.CLI`
- Cada módulo va en un fichero distinto
- Cada módulo va dentro del espacio de nombres del proyecto, por lo que todos los módulos colgarán de `RctIssues`
- Los *espacios de nombres* corresponden con directorios en el árbol del proyecto. Así, el módulo `RctIssues.CLI` se escribiría en el directorio `/lib/rct_issues/cli.ex`. Ver fichero de código fuente [cli.ex]

**Los primeros tests**

Elixir viene con un pequeño framework de testing llamado `ExUnit`.

En el fichero `/test/cli_test.exs` escribiremos los tests para el módulo que acabamos de escribir (echar un vistazo al fichero [cli_test.exs])

## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

- Necesitarás consular documentación sobre `OptionParser` para ser capaz de hacer el primer ejercicio

## Aprender lo suficiente para hacer algo de utilidad

- exercise-01-round-06: repetir (honestamente) el proceso de crear un nuevo proyecto y crear un módulo que parsee opciones de la línea de comandos y un test para ello

## Enseñar lo aprendido, y repetir desde el paso 7

