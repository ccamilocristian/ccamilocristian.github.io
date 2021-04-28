---
title: ¿Cómo interactuar con APIs en Python? Caso de estudio, resultados del Icfes en Colombia del 2019-2
author: Cristian Camilo Moreno Narvaez
date: 2021-02-06 15:00:00 -0500
categories: [Python, Economics, Data_studio]
tags: [python, api, visualizaciones, big-query]
math: true
---
Actualmente, el gobierno colombiano dispone de una plataforma para revisión de datos públicos llamado [datos.gov.co](http://gestyy.com/euLuHj) en la cual se puede extraer datos referentes a todas las áreas en las cuales trabajan los ministerios, superintendencias y demás entidades gubernamentales.

Sin embargo, esta manipulación y extracción de datos en varias ocasiones se puede volver un tema tortuoso por el número de registros y columnas de las bases. Para esto, la plataforma dispone de una [API](http://gestyy.com/euLir7) para conectar diferentes programas con esta página y extraer dicha información.

# Extracción de datos y almacenamiento

Partiendo de lo anterior, a continuación, se hará la explicación de cómo conectar esta API con python y como posteriormente almacenar dicha información en [Google Big Query](http://gestyy.com/euLoVt) para realizar visualizaciones más fáciles en Google Data Studio.

Primero, se debe instalar la librería [sodapy](http://gestyy.com/euLaFp).

```python
! pip install sodapy
```

Luego se debe importar las librerías necesarias para la manipulación de datos. Para este análisis se van a tener en cuenta los resultados del [ICFES](http://gestyy.com/euLaCV) del segundo semestre del 2019.

![ ](/assets/img/2021-02-06-icfes-conexion-api/Extraer_api.PNG)

Después se copia el último fragmento de la ruta, en este caso sería: ynam-yc42

Esta identificación de la base se copia y se pega en el código de python.

```python
import pandas as pd
from sodapy import Socrata
client = Socrata("www.datos.gov.co", None)
# se debe especificar el número de registros a importar
results = client.get("ynam-yc42", limit=546212)

# Convertir a pandas DataFrame
results_df = pd.DataFrame.from_records(results)
```

Finalmente, una vez guardada la información en python y manipulada se realiza en Google Big Query para poder almacenar en una fuente propia estos datos para posterior análisis.

```python
results_df.to_gbq("nombre_tabla_global.nombre_tabla", "nombre_proyecto", if_exists="replace", chunksize=80000)
```
En este paso, el programa pedirá permiso para acceder a la cuenta Gmail ya que Google Big Query necesita estos permisos, como se muestra a continuación.

![ ](/assets/img/2021-02-06-icfes-conexion-api/cuenta_gmail.PNG)

Finalmente, se debe copiar y pegar el token que arroja el permitir los accesos.

![ ](/assets/img/2021-02-06-icfes-conexion-api/codigo.PNG)

# Visualización 

Partiendo que la información esta almacenada en Google Big query, abrimos en el navegador Google Data Studio, un proyecto nuevo. Ya allí, abrimos los recursos para importar los datos:  

![ ](/assets/img/2021-02-06-icfes-conexion-api/importar_datos.PNG)

Ahí, seleccionamos "gestionar las fuentes de datos añadidas". Saldrá las siguientes opciones, de las cuales se debe escoger BigQuery.

![ ](/assets/img/2021-02-06-icfes-conexion-api/añadir.PNG)

Allí, se escogerá la tabla en BigQuery según el proyecto y conjunto de datos a usar.

![ ](/assets/img/2021-02-06-icfes-conexion-api/tabla.PNG)

Después de realizadas las gráficas, el resultado fue el siguiente:

<iframe width="600" height="450" src="https://datastudio.google.com/embed/reporting/ed4ce89d-0e2b-43d1-a0af-680946cccbb2/page/JdozB" frameborder="0" style="border:0" allowfullscreen></iframe>
# Análisis

Cabe aclarar que este es simplemente un análisis exploratorio de los datos, no implica causalidades ni conclusiones, solo hipótesis para futuras investigaciones.

- La mayor participación de los estudiantes se encuentra en estratos, seguido por estrato 1 y 3.
- La mayoría de las personas que presentaron el examen tenían en promedio 17 años.
- Hay una tendencia que muestra que mayor cantidad de libros en el hogar, mejor puntaje en promedio tendría los estudiantes (Esto se puede validar con un análisis de causalidad)
- Estudiantes con internet tuvieron, en promedio, mejor resultados que los estudiantes con internet.
- La categoría en la que peor les fue, en promedio, a los estudiantes de estratos bajos fue en inglés; en cambio a estratos socioeconómicos alto, esta fue la mejor categoría.
- Parece haber un óptimo de personas con las cuales vivir para tener un buen puntaje en el icfes (3-4 personas), más de 9 personas en el hogar refleja que en promedio al estudiante no le ira bien en comparación con las demás categorías de hogar.
- En promedio a los colegios masculinos les va mejor que a los colegios femeninos y mixtos.
- Parece haber una clara relación positiva con el nivel educativo de la madre y el desempeño del estudiante en la prueba.

# Mejoras

- Hacer análisis de causalidad para ver si el puntaje de los estudiantes depende de los niveles educativos de los padres.
- Revisar si los temas socioeconómicos del hogar afectan estadísticamente los resultados de los estudiantes.
- Hacer una limpieza de datos para mejorar el entendimiento de los datos y revisión de casos atípicos.

