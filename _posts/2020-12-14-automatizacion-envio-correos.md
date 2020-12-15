---
title: Automatización envío de correos 
author: Cristian Moreno
date: 2020-12-14 10:00:00 -0500
categories: [Automatizacion, Python]
tags: [automatizacion, python, correos]
math: true
---

Este es un tutorial para poder programar el envío automatico de una base de datos por correo electronico. 

```python
import pandas as pd
url = 'https://raw.githubusercontent.com/lorey/list-of-countries/master/csv/countries.csv'
df = pd.read_csv(url, sep=";")
ruta:''
```


```python
fecha=datetime.date.today().strftime('%Y-%m-%d')
df_final=ruta+"base_final_"+str(fecha)+".xlsx"
plan_emergencia_originacion.to_excel(plan_eme_orig,index = False)
```


```python
#Envío de Correo
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import os

from datetime import date
today = date.today()
# dd/mm/YY
d1 = today.strftime("%Y-%m-%d")
remitente = 'correo_remitente@gmail.com'
destinatarios = [ 'correo_destino@gmail.com']
asunto = 'Base diaria '+ d1
cuerpo = 'Buen día,'+'\n'+'\n'+'En el adjunto se encuentran las base del día de hoy.'+'\n'+'\n'+' Quedo atento a tus comentarios.'

# Datos
username = 'correo_remitente@gmail.com'
password = #contraseña
# Creamos el objeto mensaje
mensaje = MIMEMultipart()
# Establecemos los atributos del mensaje
mensaje['From'] = remitente
mensaje['To'] = ", ".join(destinatarios)
mensaje['Subject'] = asunto
# Agregamos el cuerpo del mensaje como objeto MIME de tipo texto
mensaje.attach(MIMEText(cuerpo, 'plain'))
#Agregamos el adjunto del correo
files = [df_final]

for a_file in files:
    attachment = open(a_file, 'rb')
    file_name = os.path.basename(a_file)
    part = MIMEBase('application','octet-stream')
    part.set_payload(attachment.read())
    part.add_header('Content-Disposition','attachment',filename=file_name)
    encoders.encode_base64(part)
    mensaje.attach(part)

# Convertimos el objeto mensaje a texto
texto = mensaje.as_string()
# Enviando el correo
server = smtplib.SMTP('smtp.gmail.com:587')
server.starttls()
server.login(username,password)
server.sendmail(remitente, destinatarios, texto)
server.quit()
```


![Primer paso, ir a archivos origen](/assets/img/2020-12-14-automatizacion-envio-correos/paso_1_link_python.png)
*Primer paso, ir a archivos origen*
![Segundo paso, ir a archivos origen](/assets/img/2020-12-14-automatizacion-envio-correos/paso_2_link_python.png)
*Segundo paso, ir a archivos origen*
![Tercer paso, ir a archivos origen](/assets/img/2020-12-14-automatizacion-envio-correos/paso_3_link_python.png)
*Tercer paso, ir a archivos origen*



Cambiar 