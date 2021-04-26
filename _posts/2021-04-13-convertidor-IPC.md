---
title: ¿Cómo realizar una calculadora de Inflación? Caso de estudio, Colombia entre el 2003 al 2020.
author: Cristian Camilo Moreno Narvaez
date: 2021-04-13 12:00:00 -0500
categories: [Python, Economics]
tags: [economics, python]
math: true
---

En la economía hay diferentes formas de medir el comportamiento de los agentes económicos, específicamente el comportamiento de los bienes y servicios que oferta y demanda la economía.  Una de las variables macroeconómicas que mayor importancia se tiene y que se debe controlar para el correcto funcionamiento de la economía es la inflación.

![ ](/assets/img/2021-04-14-convertidor-IPC/descarga.png)

La inflación es el aumento generalizado y sostenido de los precios de bienes y servicios en una economía durante un periodo especifico. Esto anterior, lo que quiere decir es que el poder adquisitivo de cada agente económico después de la inflación disminuye, por lo que podrán adquirir menos bienes y servicios, si todo lo demás se mantiene constante.

Para el caso colombiano, el DANE (Departamento Administrativo Nacional de Estadística) es el encargado de calcular dicha inflación a través de un índice ponderado de los precios de una cesta de bienes. La medición de este índice se puede realizar de varias formas, índice de Laspeyres y de Paasche. El DANE usa una variante del índice Laspeyres, ya que permite una actualización de la canasta para seguimiento de los precios.

![ ](/assets/img/2021-04-14-convertidor-IPC/imagen0.png)

Dado lo anterior, el presente artículo pretende mostrar cómo realizar una calculadora de inflación para el caso colombiano, con la información del IPC (Indice de Precios al Consumidor) entre el año 2003 y 2020, esto con el fin de calcular el valor en el tiempo de algún bien y servicio. La información que usaremos se encuentra en la página del [Banco de la República](https://www.banrep.gov.co/es/estadisticas/indice-precios-consumidor-ipc).

Primero, se deben importar las librerpias necesarias para el cálculo de valores y generación de gráficas.

```python
import pandas as pd
import numpy as np
pd.options.mode.chained_assignment = None 
import matplotlib.pyplot as plt
%matplotlib inline
plt.rcParams['figure.figsize'] = (14, 8)
plt.style.use('ggplot')
```

Basado en la información del IPC en base del 2018 extraido del Banco de la Republica, se genera a continuación una base que incluye el calculo de la variación anual del IPC la cual se traduce como la inflación.  

$$
\begin{aligned}
Inflación_{t}=\vartriangle IPC_{t}=\frac{IPC_{t}-IPC_{t-1}}{IPC_{t}}
\end{aligned}
$$


```python
ipc=pd.read_excel("IPC_base2018.xlsx",0)
print(ipc)
ipc['variacion']=0.0
for i in range(len(ipc)-1):
    ipc['variacion'][i+1]=(ipc['IPC'][i+1]-ipc['IPC'][i])/ipc['IPC'][i]
```

Para este caso, supondremos los siguientes valores:
+ Valor inicial: $3'000.000
+ Fecha incial: año 2005
+ Fecha final: año 2019

```python
año0=int(input("año inicial"))
añof=int(input("año final de referencia"))
valor0=int(input("valor a calcular"))
```

Por otro lado, se genera la función necesaria para relizar los cálculos en donde se trae el valor inicial de $3'000.000 en el año 2005 a precios del año 2019, a traves de la siguiente formula:

$$
\begin{aligned}
ValorFuturo_{2019}=\frac{ValorInicial*IPC_{2019}}{IPC_{2005}}
\end{aligned}
$$

```python
def calculadora(valor0,t0, tf):
    variacion=(ipc[ipc['Año']==tf]["IPC"].sum()-ipc[ipc['Año']==t0]["IPC"].sum())/ipc[ipc['Año']==t0]["IPC"].sum()*100
    final=valor0/ipc[ipc['Año']==t0]["IPC"].sum()*ipc[ipc['Año']==tf]["IPC"].sum()
    final=round(final,2)
    base=pd.DataFrame([])
    base['año']=range(t0,tf+1)
    base.set_index(base['año'], inplace=True)
    base['valor']=valor0
    base['variacion']=0.0
    for i in range(t0,tf+1):
        base['valor'][i]=valor0/ipc[ipc['Año']==t0]["IPC"].sum()*ipc[ipc['Año']==i]["IPC"].sum()
        base['variacion'][i]=ipc[ipc['Año']==i]["variacion"].sum()

    print("El valor a %s es $%s"%(t0,valor0))
    print("El valor a %s es $%s a precios de dicho este año"%(tf,final))
    print("La inflación entre los años %s y %s es de %s"%(t0,tf, round(variacion,2))+"%")
    print("Esto equivale a una inflación media anual de %s"%round(base['variacion'].mean()*100, 2)+"% "+"durante este período")
    plt.plot(base['valor']);
    plt.xlabel("Año")
    plt.ylabel("Valor en el tiempo")
    plt.title("Valor en el tiempo desde %s hasta %s"%(t0, tf))
    for a,b in zip(base.año,base.valor): 
        plt.text(a, b, str(b))
    plt.show()
    return 
```
Finalmente, se correo el código con la función creada, relacionando los valores a recisar en la calculadora, las cuales fueron mencionada anteriormente.

```python
calculadora(valor0,año0, añof)
```

Este es el resultado de la función anterior, mostrando los valores a través del tiempo en el periodo de referencia según se seleccione en la calculadora.

![ ](/assets/img/2021-04-14-convertidor-IPC/imagen2.png)

![ ](/assets/img/2021-04-14-convertidor-IPC/imagen1.png)

Como ejercicio a futuro para complementar la calculadora, se podría agregar una función la cual realice el cálculo de valor futuro a valor presente, es decir realiza el calculo de valores actuales a precios pasadaos. Por ejemplo, los mismos $3'000.000 de precios del 2020 a precios del 2000.