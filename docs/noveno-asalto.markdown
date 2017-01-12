---
layout: post
title: "Elixir: noveno asalto"
date: 2017-01-12 22:23
author: Rubén Chavarría
comments: true
categories: 
- book reviews
- lean
- agile
- devops
published: true
footer: false
sidebar: true
---

En el [asalto anterior] aprendimos un par de conceptos básicos sobre los nodos. En este asalto aprenderemos sobre servidores OTP: qué son, para qué sirven, por qué son útiles y cómo implementarlos fácilmente.

Todo esto, siguiendo el [método de aprendizaje] con el que comenzé la serie:

- Aprender lo suficiente para comenzar
- Experimentar, jugar, buscar puntos desconocidos, hacerse preguntas
- Aprender lo suficiente para hacer algo de utilidad
- Enseñar lo aprendido

<!-- https://www.flickr.com/photos/usairforce/32233424355/in/photolist-R7mJ4M-PSKWLp-PSKWzc-PSKWB6-QVSuxF-QVS4RB-Qx6jNb-PPYxBS-PSGtaD-QVNDkP-QUc3FL-PTJP1F-R7GSGZ-PQ2Wys-R7mXTv-R7mXvM-R7mXmZ-PQ2VSY-R7mWVP-PQ2VBC-R7mWCz-PQ2Vnu-R7mWiM-PQ2Vc9-R7mW2z-PQ2USS-R7mVGg-PQ2UGG-R7mVoa-PQ2Up7-R3XQdf-PQ2U4C-R3XPBW-PSL5Qv-R3XPay-PSL5sB-R3XNCw-PSL51e-R3XN45-QTcMku-R3XMCf-R3XLGh-QTcL8u-R7mR48-QVSRuR-PQ2Zwb-QVSR9R-PQ2ZdW-QVSQFB-PQ2YWd -->
<!-- https://flic.kr/p/R7mJ4M -->

{% img center /images/2016/risk.jpg %}

<div style="text-align: center">
  <span style="font-size: 60%">
Imagen basada en <a href="https://flic.kr/p/3pUVs">Risk</a> de <a href="https://www.flickr.com/photos/benstephenson/">Ben Stephenson</a>, <a href="https://creativecommons.org/licenses/by/2.0/">algunos derechos reservados</a>, licencia: <a href="https://creativecommons.org/licenses/by/2.0/">CC BY 2.0</a>
  </span>
</div>

<!-- more -->

## Aprender lo suficiente para comenzar

#### Servidores OTP

OTP (**O**pen **T**elecom **P**latform) se presenta como la solución a todos
tus problemas de escalabilidad y concurrencia. No es así, pero ayuda mucho.
Ayuda en temas como descubrimiento de aplicaciones, gestión y detección de
fallos, actualización de código en caliente y estructura del servidor.

OTP define un sistema como una jerarquía de **aplicaciones**. Una aplicación
consiste en uno o varios **procesos**. Cada uno de estos procesos implementan
un **comportamiento**. Existen comportamientos para servidores, gestores de
eventos, máquinas de estado finitas, ...

Lo implementado en ejercicios anteriores sigue un patrón con el que se podría
implementar casi todos los servidores. Por eso, OTP proporciona un mecanismo
para liberarnos de escribir el código más tedioso. La librería ofrece unas
funciones a modo de *callbacks* que irá llamando dependiendo de la situación.

#### Implementar un servidor OTP

```
defmodule Sequence.Server do
  use GenServer

  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end

end
```

`use GenServer` indica a Elixir que vamos a usar este comportamiento. Así, este
módulo representa un servidor OTP.

Uno de los callbacks proporcionados por `GenServer` es `handle_call`. Tiene 3
parametros: acción, PID del origen de la petición y el estado actual del
servidor. Tiene que responder con una tupla con tres parámetros también: la
respuesta, el valor retornado y el estado del servidor a usar en la siguiente
llamada.

Para llamar a este servidor, entramos en `iex`. Arrancamos el servidor,
indicando el módulo y el estado inicial (similar a `spawn_link`).

```
promtp$ iex -S mix
iex> { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
iex> GenServer.call(pid, :next_number)
100
iex> GenServer.call(pid, :next_number)
101
iex> GenServer.call(pid, :next_number)
102
```

#### Servidores que no tienen que devolver un resultado

En ocasiones no necesitamos que el servidor retorne un resultado. En estos
casos, para llamar al servidor emplearemos `GenServer.cast`, y para manejar
esas peticiones, nuestro servidor debe implementar el callback `handle_cast`.

#### Callbacks de GenServer

GenServer es un protocolo de OTP. OTP asume que este protocolo define 6
callbacks. Elixir proporciona una implementación por defecto para cada uno de
ellos en GenServer, por eso no tenemos que implementarlos nosotros. Los 6
callbacks son: `init(start_arguments)`, `handle_call(request, from, state)`,
`handle_cast(request, state)`, `handle_info(info, state)`,
`terminate(reason, state)`, `code_change(from_version, state, extra)` y
`format_status(reason, [ pdict, state ])`.

#### Nombrado de procesos

En lugar de usar el PID para referenciar a procesos de nuestro servidor,
podemos hacerlo a través de nombres. Para ello, se debe utilizar la opción
`name:` a la hora de crear el servidor:

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

## Aprender lo suficiente para hacer algo de utilidad

- exercise-01-round-09: crear un server que implemente una pila. Se
  inicializará con unos cuantos valores en la pila. Cada petición *pop*
devolverá un elemento de la pila. Cuando la pila esté vacía, fallará.
Implementado en `code/round-09/stack`.

- exercise-02-round-09: ampliar el servidor anterior, de forma que se puedan
  añadir elementos a la pila con la operación `:push` a través de peticiones
*cast*. Implementado en `code/round-09/stack2`

- exercise-03-round-09: dar un nombre al servidor anterior, de forma que se le
  pueda llamar sin necesidad de saber el PID. También, crear un API en la pila
de forma que los clientes no tengan que llamar a `GenServer` para usarla.
Simplemente serán unas funciones que envolverán las llamadas a `GenServer`.

- exercise-04-round-09: implementar el callback `GenServer.terminate/2` para
  comprobar distintas formas de terminar el servidor: un callback lanza una
excepción, se llama a `Kernel.exit/1`, se detecta que un proceso ha tenido un
error,... **Resultado** No he obtenido nada en claro. Tendría que profundizar
en la documentación de
[`GenServer.terminate/2`](http://elixir-lang.org/docs/stable/elixir/GenServer.html#c:terminate/2),
que parece bastante espesa por cierto. Pero no está garantizado que se llame a
`terminate`, con lo que no sé si estoy provocando correctamente los errores

## Aprender lo suficiente para hacer algo de utilidad

## Enseñar lo aprendido, y repetir desde el paso 7

Aquí está, este post, mis notas, mis pensamientos, mis dudas y mi código. Hasta
el siguiente asalto.

[Elixir]: http://elixir-lang.org/
[método de aprendizaje]: /blog/2016/01/17/aprendiendo-elixir/

