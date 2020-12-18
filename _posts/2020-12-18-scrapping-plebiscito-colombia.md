---
title: Web Scrapping plebiscito 2016 Colombia
author: Cristian Moreno
date: 2020-12-18 01:00:00 -0500
categories: [Web scrapping, Python]
tags: [automatizacion, python, web scrapping, colombia]
math: true
---


Recolección de los resultados del plebiscito 2016 Colombia.

## Descripción y Motivación
[El plebiscito](https://es.wikipedia.org/wiki/Plebiscito_sobre_los_acuerdos_de_paz_de_Colombia_de_2016) sobre los acuerdos de paz de Colombia de 2016 fue el mecanismo de refrendación para aprobar los acuerdos entre el gobierno de Colombia y la guerrilla de las Fuerzas Armadas Revolucionarias de Colombia (FARC). Las votaciones fueron programadas para el domingo 2 de octubre de 2016.

Esta fue la pregunta realizada en:

<img src=/assets/img/2020-12-18-scrapping-plebiscito-colombia/pregunta.png>

Dado lo anterior, el presente proyecto tiene como objetivo utilizar herramientas de Scrapping a de Python para extraer dicha información a nivel de municipio y departamento para posteriormente mostrar dichos resultados en un panel de Google Data Studio.

----

## Metodologías

1. El proceso de Scrapping de la página de la [Registraduría Nacional](https://elecciones.registraduria.gov.co/pre_plebis_2016/99PL/DPLZZZZZZZZZZZZZZZZZ_L1.htm) tiene las siguientes funciones: 
* Realizar el scrapping de la página principal del escrutinio de los resultados de la votación, esto para extraer el enlace de acceso a cada uno de los departamentos de Colombia en la votación. Luego de extraer la información por departamento, se extrae cada uno de los enlaces de los municipios relacionados a dicho departamento.
* Realizar el scrapping de la página de cada Municipio para extraer los resultados de las votaciones como es el % de participacion y de aprobacion al plebiscito.

<img src=/assets/img/2020-12-18-scrapping-plebiscito-colombia/Pagina_plebiscito.JPG>


En este proceso, se extrajo la información de 1.186 municipios para 34 departamentos (incluidos consulados y Bogotá DC)