---
title: ¿Cómo realizar un reproductor de música en Python?
author: Cristian Camilo Moreno Narvaez
date: 2021-01-31 11:00:00 -0500
categories: [Python]
tags: [python]
math: true
---

A continuación mostraré cómo realizar un reproductor de música haciendo uso de programación con objetos en Python.

![](/assets/img/2021-01-31-reproductor-musica/reproductor.PNG)

El resultado del siguiente código es el reproductor de la imagen anterior.

Para este proposito, en primera instancia son necesarias las siguientes librerías para el reproductor:

|Librería|Librería|
|---------|-----------|
|tkinter|pygame|
|os|mutagen|
|PIL|time|
|threaing|

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

Para comenzar con el programa, es necesario realizar la importación de las librerías mencionadas anteriormente; y así mismo, configurar la clase de reproductor de música y la función de iniciación la cual contiene el container del programa.  

<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-2402437399062384"
     data-ad-slot="1836855266"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>

```python
import tkinter as tk
import pygame
import os
from tkinter import HORIZONTAL,SUNKEN, W
from PIL import Image, ImageTk
try:
    from mutagen.mp3 import MP3
except:
    raise ValueError('Instale la libreria mutagen con: pip install mutagen')
    
    from mutagen.mp3 import MP3
import threading
import time
from tkinter.messagebox import showinfo, showerror
class ReproductorMusical(tk.Frame):
    def __init__(self, scontainer, *args, **kwargs):
        tk.Frame.__init__(self, container, *args, **kwargs)
        self.container=container
        self.cancion=""
        self.estado=""
        self.listaCanciones=[]
                  
        self.menubar = tk.Menu(self.container)
        self.container.config(menu=self.menubar)
        self.subMenu = tk.Menu(self.menubar, tearoff=0)
        self.menubar.add_cascade(label="Ayuda", menu=self.subMenu)

        pygame.mixer.init()
        self.pausado=False
        self.nombre_cancion=""
```

Luego de creado el container, se configura la información de la sección "about me". De igual manera, se configura la barra del estado de la canción y la barra de volumen, la cual por defecto está en el nivel 70.

```python

#Generacion de barra de volumen y estatus de la app 
        
#Barra estatus
self.estado = tk.Label(self.container, text="Bienvenidos al reproductor de Música de Cristian", relief=SUNKEN, anchor=W, font='Times 10 italic')
self.estado.grid(row=10, column=0, sticky="ew", columnspan=5)
#Barra de volumen
self.escala = tk.Scale(self.container,label='Volumen', from_=0, to=100, orient=HORIZONTAL , command=ReproductorMusical.barra_volumen)
self.escala.set(70)
pygame.mixer.music.set_volume(0.4)
self.escala.grid(row=5, column=0, columnspan=1)
```

Posteriormente, se realiza la configuración los botones de play, pause y stop, la imagen a usar para estos botones se pueden descargar directamente de google en formato ".png". Así mismo, se debe crear una carpeta llamada "Canciones" en la misma ruta donde se encuentra alrchivo ".py" o ".ipynb"

```python
#Generación de botones
        
##Boton de play
ruta=""
self.im1=Image.open(ruta+'play.png').resize((70, 70))
self.foto_play = ImageTk.PhotoImage(self.im1,master=container) #se utiliza el master para corregir el error de seleccionar una photo random
b=self.ReproducirCancion
self.boton=tk.Button(self.container, image=self.foto_play, command=b)
self.boton.grid(column=1, row=2)
        
##Boton de pausa
self.im2=Image.open(ruta+'pause.png').resize((70, 70))
self.foto_pause = ImageTk.PhotoImage(self.im2,master=container)#se utiliza el master para corregir el error de seleccionar una photo random
self.boton1=tk.Button(self.container, image=self.foto_pause, command=self.PausarCancion)
self.boton1.grid(column=2, row=2)

##Boton de stop
self.im3=Image.open(ruta+'stop.png').resize((70, 70))
self.foto_stop = ImageTk.PhotoImage(self.im3,master=container)#se utiliza el master para corregir el error de seleccionar una photo random
self.boton2=tk.Button(self.container, image=self.foto_stop, command=self.DetenerCancion)
self.boton2.grid(column=3, row=2)    


#Selección de la cancion a reproducir de la carpeta Canciones
os.chdir(ruta+"Canciones/")
self.listaCanciones=os.listdir()
        
self.cancion=tk.StringVar(self.container)
self.cancion.set("Seleccione la canción a reproducir: ")
        
self.menu=tk.OptionMenu(self.container, self.cancion, *self.listaCanciones)
self.menu.grid(column=0,row=0, columnspan=1)
```

Otra configuración que se agregó en el programa es la generación de descripción del estado de la canción, es decir el tiempo total de duración y el tiempo que ha trascurrido desde su inicio.

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


```python
#Descripción del total de canción y tiempo transcurrido
self.lengthlabel = tk.Label(self.container, text='Duración total de la canción: --:--')
self.lengthlabel.grid(column=1,row=4, columnspan=3)

self.currenttimelabel = tk.Label(self.container, text='Tiempo transcurrido : --:--')
self.currenttimelabel.grid(column=1,row=5, columnspan=3)


#Titulo de la app
self.barra=tk.Label(self.container, text="Reproductor de música", font="Times 12 italic")
self.barra.grid(column=1,row=0, columnspan=3)

self.container.protocol("WM_DELETE_WINDOW", self.cierre)        

```

<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-2402437399062384"
     data-ad-slot="1836855266"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>

Finalmente, para el correcto desarrollo del programa, se empalma a funciones las anteriores configuraciones dependediendo el objetivo a desarrollar. Para eso, las funciones que se realizaron fueron:

+ Sobre mi
+ Reproducir canción
+ Pausar canción
+ Cierre del programa
+ Barra de volumen
+ Detener canción
+ Mostrar detalles en la barra de información
+ Comenzar conteo de la canción

```python
def Sobre_Mi(self):
    """
    Este método tiene como objetivo mostrar una ventana con información mia y de la app.
    """
    showinfo('Sobre el Reproductor', ' Este reproductor de música fue construido con las librerias de Python TKinter & Pygame, por Cristian Moreno')

def ReproducirCancion(self):
    """
    Este método reanuda la canción si esta se encontraba en pause y la reproduce si es la primera vez.
    """
        
    if self.pausado:
        pygame.mixer.music.unpause()
        self.estado['text'] = "La canción fue reanudada"
        self.pausado = False
    else:
        try:
            self.DetenerCancion()
            nombre_cancion=self.cancion.get()
             
            pygame.mixer.music.load(nombre_cancion)
            pygame.mixer.music.play()
            self.mostrar_detalles(nombre_cancion)
             
            self.estado['text'] = "Reproduciendo la siguiente canción:" + ' - ' + os.path.basename(nombre_cancion)

        except:
            showerror('Archivo no encontrado', ' El reproductor no encontro ninguna canción en la ruta. Por favor verificar nuevamente.')
            print("Error")

def PausarCancion(self):
    """
    Este método pausa la canción y cambia el estado de la app
    """
        
    self.pausado = True
    if self.pausado: 
        pygame.mixer.music.pause()
        self.estado['text'] = "Canción pausada"        

def cierre(self):
    """
    Esta función detiene la canción y destruye el programa al cerrar el mismo.
    """
    ReproductorMusical.DetenerCancion(self)
    self.container.destroy()    
```

![](/assets/img/2021-01-31-reproductor-musica/4_funciones.png)

```python
def barra_volumen(val):
    """
    Esta función genera los valores de la barra de volumen
    """
    volumen = int(val) / 100
    pygame.mixer.music.set_volume(volumen)


def DetenerCancion(self):
    """
    Este método detiene la canción
    """
    pygame.mixer.music.stop()
    self.estado['text'] = "Canción detenida"
def mostrar_detalles(self,reproducir_cancion):
    """
    Este método es el encargado de modificar el estado de la canción, es decir el tiempo transcurrido
    """
    nombre_cancion = os.path.splitext(reproducir_cancion)

    if nombre_cancion[1] == '.mp3':
        audio = MP3(reproducir_cancion)
        Duracion_total = audio.info.length
    else:
        a = pygame.mixer.Sound(reproducir_cancion)
        Duracion_total = a.get_length()
        
        
    mins, secs = divmod(Duracion_total, 60)
       
    mins1 = round(mins)
    secs1 = round(secs)
        
    timeformat = '{:02d}:{:02d}'.format(mins1, secs1)
    self.lengthlabel['text'] = "Duración total de la canción" + ' - ' + timeformat
        
    t1 = threading.Thread(target=self.comenzar_conteo, args=(Duracion_total,))
    t1.start()
def comenzar_conteo(self, t):
    """
    Este método realiza el conteo de segundos transcurridos desde el inicio de la canción. Cuando se encuentra en pause, pygame.mixer.music.get_busy() sera falso y parará el conteo.
    """
    current_time = 0
    while current_time <= t and pygame.mixer.music.get_busy():
        if self.pausado:
            continue
        else:
             
            mins, secs = divmod(current_time, 60)
            mins = round(mins)
            secs = round(secs)
            timeformat = '{:02d}:{:02d}'.format(mins, secs)
            self.currenttimelabel['text'] = "Tiempo transcurrido" + ' - ' + timeformat
            time.sleep(1)
            current_time += 1
```

![](/assets/img/2021-01-31-reproductor-musica/8_funciones.png)

Finalmente, es necesario realizar el llamado de la clase para poder correr el código generado anteriormente.

```python
container=tk.Tk()
container.title("Proyecto reproductor de música")
container.geometry("500x250")
app = ReproductorMusical(container)
app.mainloop()
```

# Mejoras

+ Mejorar el estilo del programa en términos de colores y letra.
+ Poder reproducir canciones de youtube a través de un enlace.
+ Agregar la función de reproducir la canción con una velocidad mayor o menor.

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
