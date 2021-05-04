---
title: Mercado laboral Colombiano. Caso de estudio, Programa STEP
author: Cristian Camilo Moreno Narvaez
date: 2021-05-03 15:00:00 -0500
categories: [Python,Economics]
tags: [economics, python, regression]
math: true
---

La automatización de trabajos corresponde al desarrollo e inclusión de nuevas tecnologías en las cadenas de valor de las empresas. Sin embargo, este cambio en la estructura laboral de las empresas lleva impactos negativos como positivos en el mercado laboral. La investigación titulada "El futuro del empleo: ¿Qué tan susceptible son los empleos a la computarización?" realizada por Frey & Osborne en el año 2017 es uno de los puntos de partida para muchas investigaciones a la hora de analizar el impacto futuro de los robots en el mercado laboral. En este artículo los autores desarrollaron un cálculo a nivel de ocuación en donde encontraron la probabilidad de ser automatizadas en los próximos 10 años en Estados Unidos, esto a traves de un modelo de Machine Learning.

![ ](/assets/img/2021-05-03-step-colombia/pexels-alex-knight-2599244.jpg)

Con base en lo anterior, siguiendo a Bustelo et al. (2020) se desarrollará la metodología para ajustar la probabilidad de automatización de las ocupaciones en Colombia, basado en el cálculo de Frey & Osborne (2017) y los datos recolectados por el Banco Mundial en el proyecto [STEP](https://microdata.worldbank.org/index.php/catalog/2012) (Skills Toward Employment and Productivity), para así obtener medidas relacionadas a las habilidades que desempeñan los trabajadores en ciertas ocupaciones.

Además, este resultado anterior puede ayudarnos a vislumbrar el riesgo que podrían tener las ocupaciones actuales, y los sectores económicos,  ante choques tecnológicos, específicamente la llegada de robots.

Este programa STEP se desarrolló en el año 2012 para 13 áreas metropolitanas de Colombia, para 1550 personas encuestadas, teniendo como alcance las siguientes características:

+ Demográficas del hogar
+ Vivienda
+ Salud
+ Empleo
+ Habilidades laborales
+ Personalidad, comportamiento y preferencias
+ Idioma y antecedentes familiares
+ Evaluación de la prueba de lectura

# Construcción de variables

Las variables necesarias para el modelo están descritas de la siguiente manera:

| Syntax      | Descripción |
| :-----------: | ----------- |
| ICT digital      | Habilidades en tecnologías de la información y la comunicación       |
| Management and communication  |Habilidades en gestión y comunicación |
 Readiness to learn and creativity        |Habilidades en disposición para aprender y resolución creativa de problemas|
| Self-organization      | Habilidades para autoorganizarse|
| Marketing and accounting      | Habilidades en Marketing y contabilidad       |
| Physical      | Habilidades en trabajo físico demandante       |
|STEM quantitative|Habilidades en ciencia, tecnología, ingeniería y matemáticas|

Se construyen las medidas siguiendo el proceso de estandarización del Z-score con el fin de sobrellevar la dificultad de tener medidas en diferentes escalas. Para empalmar los datos del programa STEP con los riesgos de automatización calculados por Frey & Osborne (2017), se realiza la correlativa a nivel de ocupación y nivel demográfica. La correlativa usada es con el código SOC (Standard Occupational Classification a nivel de 6 dígitos) con el código ISCO de Estados Unidos (Internacional Standar Classification of Ocuppations a nivel de 3 dígitos).

![ ](/assets/img/2021-05-03-step-colombia/correlacion.PNG)



|Variables|Media|Desviación estandar|
|---|---|---|
|ICT|-0.01479|0.990889|
|Management & Communication|-0.015207|0.99609|
|Readiness to learn & Creativity|-0.004358|1.001575|
|Self-Organization|-0.002029|1.002626|
|Marketing and Accounting|0.007716|0.998354|
|STEM quantitative|-0.006013|0.997693|
|Physical|0.001656|1.002446|
|estrato socio-económico|2.395484|0902821|
|gender|0.500645|0.500161|
|age|35.630323|11.619844|
|Educación superior|0.342581|0.474726|
|Riesgo Automatización|0.628414|0.247711|

![ ](/assets/img/2021-05-03-step-colombia/edad1.png)

La gráfica anterior muestra una concentración en la cola izquierda, en donde la media es 35 años, como los muestra la tabla de descriptivos.

![ ](/assets/img/2021-05-03-step-colombia/estrato1.png)

Por otro lado, la encuestra presenta una concentración en los estrados 2 y 3 de la población colombia; sin embargo, estos no son significativos para el total de la población del país. Para esto, es necesario empalmar los datos con encuestas como la GEIH (Gran Encuesta Integrada de Hogares) del DANE, la cual presenta factores de expasión para tener en cuenta el total de la población.

# Construcción del modelo
El modelo a estimar es el siguiente:

$$ y_i= \sum_{n=1}^{N}\beta_{n}*X_{in} + \varepsilon_{i} $$

donde $$y$$ es el riesgo de automatización por ocupación en donde el trabajador $$i$$ fue empleado y $$X_n $$ son las variables que capturan el conjuto de 7 medidas de las habilidades por trabajador $$i$$, nivel educativo, grupo de la edad y genero. $$N$$ es el número de variables independientes a incluir en el modelo.

![ ](/assets/img/2021-05-03-step-colombia/ModeloSTEP.PNG)

# Resultados

## Edad

La siguiente gráfica muestra la probabilidad ajustada, donde la población de ocupados que mayor probabilidad de ser automatizados tiene son aquellos que se encuentran entre los 18 y 25 años, seguidos por las personas entre 26 y 40. Esto podría deberse a la especialización en las tareas a desempeñar y a que personas con mayor edad pueden tener más altos niveles educativos que los más jóvenes.

![ ](/assets/img/2021-05-03-step-colombia/ries_edad.png)

## Genero

El género que mayor probabilidad de ser automatizado es el género femenino. Para entender con mayor profundidad este resultado, se debería contrastar las ocupaciones y habilidades que desempeñan las mujeres en Colombia, esto con el fin de generar políticas públicas de inclusión de género para así mitigar el impacto futuro en el mercado laboral.

![ ](/assets/img/2021-05-03-step-colombia/genero.png)

## Nivel educativo

Como es de esperarse, los niveles más altos de educación tienen menor probabilidad de ser automatizados; sin embargo, al no ser la muestra representativa para la población colombiana, no podemos asegurar con certeza si esta probabilidad también está acorde a la realidad actual de la población colombiana, específicamente el nivel de preescolar. Investigadores como David Autor han relacionado esta distribución de automatización y nivel educativo con un concepto llamado [polarización](https://www.stlouisfed.org/publications/regional-economist/january-2013/job-polarization-leaves-middleskilled-workers-out-in-the-cold#:~:text=An%20important%20point%20Autor%20made,pronounced%20during%20the%20Great%20Recession.) donde los niveles medios de educación son los que mayores efecto están teniendo con la inclusión de nuevas tecnologías en el mercado laboral.

![ ](/assets/img/2021-05-03-step-colombia/ries_edu.png)

## General

Finalmente, a continuación, se ve la distribución de los riesgos de automatización de Frey y Osborne para el caso de las ocupaciones en el programa versus el ajuste realizado con el modelo.

![ ](/assets/img/2021-05-03-step-colombia/vs.png)

La diferencia en probabilidades es explicada porque el método de task-based aproach considera la variación de la estructura de tareas dentro de las ocupaciones mientras que Frey & Osborne (occupation- base approach) ignora esta variación. Frey & Osborne asumen que todos los trabajadores de una ocupación enfrentan el mismo riesgo de automatización. Es decir, en lugar de asumir que las ocupaciones son desplazadas por las máquinas, con el método task-based aproach se argumenta que ciertas tareas pueden desplazarse

Por último, es de vital importancia realizar más investigaciones sobre el impacto que podría tener estas nuevas tecnologías en países de tercer mundo, específicamente en Colombia, en el mercado laboral. Como publicación futura, mostraremos el estado del arte en Colombia sobre el impacto de la automatización de tareas, para hacer un llamado a la acción de tener en cuenta este inminente riesgo y como cada persona desde su ámbito profesional y académico intenta disminuir este riesgo de ser automatizado por robots o algoritmos inteligentes de aprendizaje autónomo.




# Referencias
+ Frey, C. B., & Osborne, M. A. (2017). “The future of employment: How susceptible are jobs to
 computerisation? Technological Forecasting and Social Change”, 114, 254–280.
+ Bustelo, M., Egana-delSol, P., Ripani, L., Nicolas, S., & Viollaz, M. (2020). Automation in Latin America: Are Women at Higher Risk of Losing Their Jobs? Inter-American Development Bank.
+asdf