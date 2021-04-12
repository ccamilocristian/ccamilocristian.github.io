---
title: ¿Cómo programar el envío automático de correos con Python?
author: Cristian Camilo Moreno Narvaez
date: 2020-12-17 15:00:00 -0500
categories: [Python,Automatizacion]
tags: [automatizacion, python, correo, windows, gmail]
math: true
---

A continuación, desarrollaremos un tutorial con el fin de automatizar el envío de una base de datos por correo electrónico, usando únicamente python 3 y el programador de tareas de Windows.

Para poder realizar esta función de envío automático, se debe generar un archivo .py con el código que se va a describir.

En primera medida, usaremos una base de datos online que se encuentra en la ruta "url". Esta base de datos tiene la información de países relacionada a características básicas como moneda, capital, entre otros.


```python
import pandas as pd
url = 'https://raw.githubusercontent.com/lorey/list-of-countries/master/csv/countries.csv'
df = pd.read_csv(url, sep=";")
ruta:'' # aca va la ruta donde se va a alojar la base de datos
```

Se programa la generación de la fecha del día del envío de la base con la librería datetime, como se muestra a continuación y se guarda la base de datos a un excel en la ruta especificada anteriormente:

```python
import datetime
fecha=datetime.date.today().strftime('%Y-%m-%d')
df_final=ruta+"base_final_"+str(fecha)+".xlsx"
df.to_excel(df_final,index = False)
```

Luego, se importan las librerías necesarias para el envío del correo en python.

```python
#Envío de Correo
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import os
from datetime import date
```

Estas siguientes líneas de código relacionan el remitente, destinatario, asunto y cuerpo del correo.

```python
today = date.today()
# dd/mm/YY
d1 = today.strftime("%Y-%m-%d")
remitente = 'correo_remitente@gmail.com'
destinatarios = [ 'correo_destino@gmail.com']
asunto = 'Base diaria '+ d1
cuerpo = 'Buen día,'+'\n'+'\n'+'En el adjunto se encuentran las base del día de hoy.'+'\n'+'\n'+' Quedo atento a tus comentarios.'
```

Finalmente, se configura la dirección del correo y la contraseña. Así mismo, se configura la información que irá en el correo, adjuntos, remitentes, destinatarios y asuto.
Para poder usar gmail para este fin, es necesario [dar acceso a aplicaciones no segura](https://docs.rocketbot.co/?p=1567).

![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_gmail.PNG)

```python
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

Luego de tener configurado el python en formato .py, se procede a programar el script que corra automaticamente dicho código. Para esto, se deben seguir los siguientes pasos para extaer la ruta donde se debe correr el código de python

1. Se debe dirigir a la carpeta donde se encuentran los archivos relacionados a powershell de Anaconda. <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_1_link_python.png)

2. Se entra a las propiedades del archivo "Anaconda Prompt". <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_2_link_python.png)

3. Ya en la configuración del programa, se copia la ruta que se encuentra en el campo "Target". <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_3_link_python.png)

4. Luego se debe crear un blog de notas, se pega la ruta del punto anterior, la ruta del archivo python (.py) y se modifica para quede de la siguiente manera: <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso4_bat.PNG) <br />
Para este paso, transformar el nombre blog de notas guardado a extensión .bat, ejemplo: "envio_automatico.bat"

5. Abrir programador de tareas en windows e ir a crear tarea. Ingresa el nombre de la tarea y descripción de la misma. <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso5_task.PNG)

6. Agrega el desencadenador, el cual es una rutina diaria que se ejecuta, para este caso, a las 12 pm desde el primero de diciembre del año 2020. <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso6_desencadenador.PNG) <br />

7. Finalmente, agrega una acción la cual es el script .bat que creaciamos a partir del blog de notas y la ruta de ejecución del python. <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso7_action.PNG) <br />

Así se debe visualizar la tarea en la aplicación de programación de tareas:
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_final.PNG) <br />

Finalmente, el resultado de todos los procesos anteriores es un correo automático que se envía diariamente como se muestra a continuación:

![ ](/assets/img/2020-12-14-automatizacion-envio-correos/correo.PNG)

Contras del proceso:

- Se necesita que el computador este prendido.
- Hay cierto nivel de riesgo si se envia información delicada, ya que hay intervención de un tercero (la libreria usada en python para el envío de correos)

Mejoras al proceso:

- Hacer este mismo proceso en alguna máquina virtual en la nube para que se corra sin ninguna intervención humana.
