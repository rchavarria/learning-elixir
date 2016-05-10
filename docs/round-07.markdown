# Elixir: sexto asalto (mix, ExUnit, DocTests)

## Aprender lo suficiente para comenzar

Referencia: [Ejercicios y foros sobre el libro](https://forums.pragprog.com/forums/322)

#### Modelo de concurrencia

**Trabajando con múltiples procesos**

Elixir usa el modelo de *actor* para gestionar la concurrencia.

Elixir se apoya en Erlang para gestionar los procesos, que no son los procesos del sistema operativo.

Para crear un proceso, se hace con la llamada `spawn`. `spawn` puede crear un proceso y ejecutar en él código que tengas en un módulo cualquiera. El proceso puede empezar en cualquier momento (asíncrono total) y se utilizan mensajes entre procesos para sincronizarlos.

Los mensajes no tienen por qué ser `Strings`, pueden ser de cualquier tipo (generalmente tuplas o atoms). Los mensajes se mandan con `send`, y debes usar un `PID` (devuelto por `spawn`).

El receptor, espera mensajes con `receive`. `receive` funciona como `case`: se pueden poner varios casos, y el primero que coincida, se ejecuta.

`receive` maneja sólo un mensaje. Si queremos recibir varios, debemos volver a llamar al método que contiene el `receive`, de forma recursiva (y Elixir es muy bueno con la recursividad). `receive` también acepta un parámetro, `after`, para definir un timeout.

**Demasiados procesos**



## Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas

## Aprender lo suficiente para hacer algo de utilidad

## Enseñar lo aprendido, y repetir desde el paso 7

