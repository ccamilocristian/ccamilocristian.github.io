---
title: How make an inflation calculator? Case of study, Colombia between 2003 and 2020.
author: Cristian Camilo Moreno Narvaez
date: 2021-04-13 12:00:00 -0500
categories: [Python, Economics]
tags: [economics, python]
math: true
---

In the economy, there are different forms to measure the behavior of the economic agents, specifically in the goods and services demanded and supplied in the economy. One of the macroeconomic variables with the most importance is inflation. The inflation variable needs to be controlled to have a good economic performance. 

![ ](/assets/img/2021-04-14-convertidor-IPC/descarga.png)

Inflation is the generalized increase and sustained of the goods and services prices in an economy during a specific period. That means the purchasing power parity of each economic agent inflation, decrease, and for that reason, they can not acquire the same amount of goods and services as before, where everything keeps constant.


<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- horizontal ad -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-2402437399062384"
     data-ad-slot="8047040393"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>

For this case, the [DANE](gestyy.com/euK27v) (Departamento Administrativo Nacional de Estadística) is in charge of calculating the inflation in Colombia with the use of the ponderation price index to a basket of goods. The measure of the index can be done in two ways, [Laspeyres and Paasche](gestyy.com/euK3Fc) index. The DANE uses a variant of the Laspeyres index because it allows an easy actualization of the basket of goods to the price tracking.

![ ](/assets/img/2021-04-14-convertidor-IPC/imagen0.PNG)
The present article pretends to show how to make an inflation calculator, in the Colombian case. with the [IPC](gestyy.com/euK3BY) (Indice de Precios al Consumidor) information between 2003 and 2020. The calculator has the objective to measure the time valor of the goods and services in Colombia. The information was sustract from the [Banco de la República](gestyy.com/euK32D)'s website.

First, we import the needed libraries to compute the values and generate the graphs. 

```python
import pandas as pd
import numpy as np
pd.options.mode.chained_assignment = None 
import matplotlib.pyplot as plt
%matplotlib inline
plt.rcParams['figure.figsize'] = (14, 8)
plt.style.use('ggplot')
```

With the IPC's information based on 2018 extracted from the Banco de la Republica, later we generate a database that includes the annual variation of the IPC, i.e. the inflation. 

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

In this case, we suppose the next values: 
+ Initial value: $3'000.000
+ Initial date (year): 2005
+ Final date (year): 2019

```python
año0=int(input("año inicial"))
añof=int(input("año final de referencia"))
valor0=int(input("valor a calcular"))
```

On the other hand, we generate the function to generate the computation base on the initial value of $3'000.000 in 2005 to prices of 2019, using the following formula:

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

Finally, we run the code with a function that relates to the values mentioned in the previous section.

```python
calculadora(valor0,año0, añof)
```

This is the result of the previous function, showing the values across the time in the reference period according to values selected in the calculator.


![ ](/assets/img/2021-04-14-convertidor-IPC/imagen2.PNG)

![ ](/assets/img/2021-04-14-convertidor-IPC/imagen1.PNG)

As a future project to complements this calculator, the reader can add a function that computes the future value to present value, i.e. compute current prices to past prices. For example, the same previous $3'000.000 in 2020's prices to 2000's prices.

<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- horizontal ad -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-2402437399062384"
     data-ad-slot="8047040393"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
