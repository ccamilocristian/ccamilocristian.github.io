---
title: How to build a fixed-payment loan simulator in Python?
redirect_from:
  - /posts/liquidador-intereses/
author: Cristian Camilo Moreno Narvaez
date: 2021-04-11 17:00:00 -0500
categories: [Python, Riesgo]
tags: [python, visualizaciones, credito]
math: true
domain: Business Intelligence
technical_level: Advanced
reading_time: 3
business_impact: "Strengthens KPI monitoring and executive decision cadence."
impact_label: "Fixed-payment loan amortization simulator"
description: "Simulate a fixed-rate loan in Python with numpy_financial—monthly payment, amortization table, and charts of the declining balance."
---
Taking out loans is one of the most common banking operations for everyday borrowers who need capital to invest or cover expenses they could not otherwise afford. These loans are not free: the price is the interest rate. Each bank in each country sets its own rate depending on the product—consumer credit, mortgages, housing loans, and so on.

Before applying for credit, it helps to understand the available payment structures so you do not fall behind and end up with negative reports in credit bureaus such as [Datacrédito](https://www.datacredito.com.co/) in Colombia.

The total cost of a loan depends heavily on the interest rate and on the payment schedule—for example, equal monthly installments versus variable installments tied to accrued interest, and whether an upfront payment is required.

In this post we show how to build a fixed-payment loan simulator in Python, which can be useful when comparing offers from financial institutions.

# Building the simulator

First, install and import the required libraries. The main one is `numpy_financial`, which calculates the monthly installment; it can also compute interest rates and balances.

```python
! pip install numpy_financial

import numpy as np
import pandas as pd
import numpy_financial as npf
import warnings
warnings.filterwarnings('ignore')
```

Next, define the simulator parameters: monthly interest rate, amount to finance, term in months (this simulator uses monthly frequency), and optional down payment.

```python
tasa=0.0109
monto_financiar=500000
plazo=18
cuota_inicial=0
```

For this example we assume a 1.09% monthly rate, COP $500,000 financed over 18 months with no down payment—meaning each payment covers both principal and interest.

Then build a function that computes installments and returns an amortization table for each month. The function asks how many initial installments to pay; here we use 0 (the function handles loans with or without a down payment).

```python
def cuota_fija(tasa,monto_financiar, plazo, cuota_inicial ):
    base_liquidador=pd.DataFrame([])
    cuota=npf.pmt(tasa, plazo,-monto_financiar, 0)
    cuotas_iniciales=int(input("Enter value: "))
    if cuotas_iniciales==1:
        base_liquidador=pd.DataFrame([])
        base_liquidador['Mes_cuota']=["Mes_%s"%(i+1) for i in range(plazo+1)]
        base_liquidador['Saldo']=0
        base_liquidador['Intereses']=0
        base_liquidador['Saldo'][0]=monto_financiar
        base_liquidador['Saldo'][1]=monto_financiar-cuota_inicial 
        
        base_liquidador['pago_mes']=int(cuota)
        base_liquidador['pago_mes'][0]=cuota_inicial
        base_liquidador['amortización']=0
        base_liquidador['amortización'][0]=cuota_inicial
        base_liquidador['tasa_interes']=tasa
        base_liquidador['Saldo_final']=0

        for i in range(0, len(base_liquidador)):
            base_liquidador['Intereses'][i+1]=(base_liquidador['Saldo'][i]*base_liquidador['tasa_interes'][i])
            base_liquidador['amortización'][i]=np.where(base_liquidador['Saldo'][i]>base_liquidador['Intereses'][i],(base_liquidador['pago_mes'][i]-base_liquidador['Intereses'][i]),base_liquidador['Saldo'][i] )
            base_liquidador['Saldo'][i+1]=base_liquidador['Saldo'][i]-base_liquidador['amortización'][i]
            base_liquidador['pago_mes'][i]=np.where(base_liquidador['Saldo'][i]>base_liquidador['amortización'][i], base_liquidador['pago_mes'][i], base_liquidador['Saldo'][i])
            base_liquidador['Saldo_final'][i]=base_liquidador['Saldo'][i]-base_liquidador['amortización'][i] 

    elif cuotas_iniciales==0:
        base_liquidador=pd.DataFrame([])
        base_liquidador['Mes_cuota']=["Mes_%s"%(i+1) for i in range(plazo)]
        base_liquidador['Saldo']=0
        base_liquidador['Saldo'][0]=monto_financiar
        base_liquidador['Intereses']=0
        base_liquidador['pago_mes']=int(cuota)
        base_liquidador['amortización']=0
        base_liquidador['tasa_interes']=tasa
        base_liquidador['Saldo_final']=0
        
        for i in range(0, len(base_liquidador)):
            base_liquidador['Intereses'][i]=(base_liquidador['Saldo'][i]*base_liquidador['tasa_interes'][i])
            base_liquidador['amortización'][i]=np.where(base_liquidador['Saldo'][i]>base_liquidador['Intereses'][i],(base_liquidador['pago_mes'][i]-base_liquidador['Intereses'][i]),base_liquidador['Saldo'][i] )
            base_liquidador['Saldo'][i+1]=base_liquidador['Saldo'][i]-base_liquidador['amortización'][i]
            base_liquidador['Saldo_final'][i]=base_liquidador['Saldo'][i]-base_liquidador['amortización'][i]    
    else: 
        print("Oops! Invalid value. Try again...")    
    return base_liquidador
```

Run the function with the parameters defined above.

```python
df=cuota_fija(tasa,monto_financiar, plazo, cuota_inicial )
print(df)
```

# Amortization charts

The table below shows amortization behavior over the 18-month term.

![ ](/assets/img/2021-04-11-liquidador-intereses/Tabl1.PNG)

The following code plots the outstanding principal balance.

```python
import matplotlib.pyplot as plt
plt.figure(figsize=(15,8))
plt.plot(df.Mes_cuota,df.Saldo,label='Saldo')
plt.xlabel('Months')
plt.gcf().axes[0].yaxis.get_major_formatter().set_scientific(False)
plt.title('Outstanding balance')
for a,b in zip(df.Mes_cuota,df.Saldo): 
    plt.text(a, b, str(b))
plt.legend()
plt.show()
```

The chart below shows how the debt balance evolves across payment periods.

![ ](/assets/img/2021-04-11-liquidador-intereses/saldo.PNG)

Finally, this code plots cumulative principal amortization for each period.

![ ](/assets/img/2021-04-11-liquidador-intereses/capital.PNG)

As Albert Einstein reportedly said, compound interest is the eighth wonder of the world: those who understand it benefit; those who do not pay it. As a reader exercise, try extending the simulator to variable-payment loans.
