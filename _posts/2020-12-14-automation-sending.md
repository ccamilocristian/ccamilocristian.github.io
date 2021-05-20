---
title: How can I use Python to automate the sending of emails?
author: Cristian Camilo Moreno Narvaez
date: 2020-12-17 16:00:00 -0500
categories: [Python,Automation]
tags: [automation, python, correo, windows, gmail]
math: true
---

Up next, we will develop a tutorial to automate the sending of databases via email, using only Python 3 and the Windows Task Scheduler.


![ ](/assets/img/2020-12-14-automatizacion-envio-correos/descar.jpg)

The first step to make the automatic sending function is generating a .py file with the following code. We will use a online database which is in the path "url". This database contains details about the country's basic characteristics, such as money, resources, and so on.


```python
import pandas as pd
url = 'https://raw.githubusercontent.com/lorey/list-of-countries/master/csv/countries.csv'
df = pd.read_csv(url, sep=";")
ruta:'' # Here goes the path where the databases will be. 
```

We program the generation of the date, specifically the sending day with the library datetime, as we show up follow, and we save the database in an excel file in the specified path previously:

```python
import datetime
fecha=datetime.date.today().strftime('%Y-%m-%d')
df_final=ruta+"base_final_"+str(fecha)+".xlsx"
df.to_excel(df_final,index = False)
```

Then, we import the needed libraries to send the email with Python. The main libraries are smtplib and email.

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

The following lines of code are related to the sender, receiver, subject, and body of the email.

```python
today = date.today()
# dd/mm/YY
d1 = today.strftime("%Y-%m-%d")
remitente = 'email_sender@gmail.com'
destinatarios = [ 'email_reciever@gmail.com']
asunto = 'Base diaria '+ d1
cuerpo = 'Buen día,'+'\n'+'\n'+'En el adjunto se encuentran las base del día de hoy.'+'\n'+'\n'+' Quedo atento a tus comentarios.'
```

Finally, we set up the email address and the password. In addition, we set up the information that will be in the email, attachments, sender, receiver, and the subject.
It is important to grant access to the non-secure apps [in order to use Gmail for this purpose](http://gestyy.com/euK5g2).


![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_gmail.PNG)

```python
# data
username = 'email_sender@gmail.com'
password = #password
# We create the message object calls "mensaje"
mensaje = MIMEMultipart()
# We set the attributes of the message 
mensaje['From'] = remitente
mensaje['To'] = ", ".join(destinatarios)
mensaje['Subject'] = asunto
# We add the body of the email with the object MINE by string type
mensaje.attach(MIMEText(cuerpo, 'plain'))
#We add the attachments to the email
files = [df_final]

for a_file in files:
    attachment = open(a_file, 'rb')
    file_name = os.path.basename(a_file)
    part = MIMEBase('application','octet-stream')
    part.set_payload(attachment.read())
    part.add_header('Content-Disposition','attachment',filename=file_name)
    encoders.encode_base64(part)
    mensaje.attach(part)

#  We convert the object "mensaje" in a string.
texto = mensaje.as_string()
# We send the email.
server = smtplib.SMTP('smtp.gmail.com:587')
server.starttls()
server.login(username,password)
server.sendmail(remitente, destinatarios, texto)
server.quit()
```
We continue to program the script that runs the code automatically after setting up the python in the.py format. To accomplish this, we must first extract the path where the python code must run.

1. We go to the carpets where the files related to [Anaconda's](http://gestyy.com/euK5xM) PowerShell. <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_1_link_python.png)

2. We go to the properties of the file "Anaconda Prompt".<br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_2_link_python.png)

3. Once the program was configured, we copy the path into label "Target". <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_3_link_python.png)

4. We create a notepad file, we page the previous path, and we modify it in the following way:<br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso4_bat.PNG) <br />
For this step, we transform the name of the notepad file and save it with .bat extensions, like this: "envio_automatico.bat"

5. We open the Task scheduler of Windows and go to create a new task. We introduce the name and description of the task.<br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso5_task.PNG)

6.  We add the trigger which is a daily routine that runs at noon since December 1, 2020. <br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso6_desencadenador.PNG) <br />

7. Finally, we add an action that is the previous script .bat that we built from the notepad file, as well as the Python's path of execution.<br />
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso7_action.PNG) <br />

That is how the task should look in the Task Scheduler:
![ ](/assets/img/2020-12-14-automatizacion-envio-correos/paso_final.PNG) <br />

Finally, the result of all the previous processes is an automatic email that is sent every day like it shows up next:

![ ](/assets/img/2020-12-14-automatizacion-envio-correos/correo.PNG)

Disadvantages: of the process:

- The computer must be turned on at all time.
- If we send confidential information, there is a degree of danger. There is a third-party interference (The library used in python for the email sending)

Potencial improves in the process:

- You can develop it in a virtual machine in the cloud. It would run without any human intervention.  

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
