---
title: Decrees and Resolutions of Colombia's Ministry of Health and Social Protection (2000–2020)
redirect_from:
  - /posts/ministerio-salud/
  - /minsalud-decrees-english/
author: Cristian Camilo Moreno Narvaez
date: 2021-04-12 01:00:00 -0500
categories: [Python, Web_scraping]
tags: [automatizacion, python, web-scraping, colombia, visualizaciones]
math: true
domain: Business Intelligence
technical_level: Advanced
reading_time: 5
business_impact: "Strengthens KPI monitoring and executive decision cadence."
impact_label: "MinSalud regulatory text mining (2000–2020)"
description: "Selenium scrapers, PDF transcription, and text mining on MinSalud decrees and resolutions from 2000 to 2020—coverage, epidemics, fraud."
---
According to [McKinsey](https://www.mckinsey.com/) research, analysis of unstructured data—audio, text, and images—has strong future potential because of the volume stored and the relatively little investigation done so far.

This document presents an exploratory analysis of unstructured text extracted from PDFs, focusing on two key administrative instruments: **decrees** and **resolutions** issued between 2000 and May 2020. The exploratory work links macroeconomic and health indicators to surface inputs for future causal and correlation studies.

The following questions motivated the analysis:

- Over the last 20 years, several global health crises have occurred. Do the data reflect Colombia's regulatory and control responses?
- Public health spending has fluctuated in recent years. Do the documents reflect that policy shift?
- As a country generates more income, social welfare and health coverage tend to rise. Do the data reflect coverage dynamics in Colombia?
- Can administrative acts since 2000 help explain the rise in affiliations under both the contributory and subsidized regimes?

----

## 1. Methodology

### Scraping

Scraping is split into two notebooks: [Scrapping_Decretos_MinSalud.ipynb](https://github.com/ccamilocristian/Scrapping_MinSalud/blob/master/Decretos/Scrapping_Decretos_MinSalud.ipynb) for decrees and [Scrapping_Resoluciones_MinSalud.ipynb](https://github.com/ccamilocristian/Scrapping_MinSalud/blob/master/Resoluciones/Scrapping_Resoluciones_MinSalud.ipynb) for resolutions.

Each script has two stages:

1. Fetch record counts, year, and year index to drive page scraping.
   - 558 decrees — [Decretos MinSalud](https://www.minsalud.gov.co/Paginas/Norm_Decretos.aspx)
   - 1,406 resolutions — [Resoluciones MinSalud](https://www.minsalud.gov.co/Paginas/Norm_Resoluciones.aspx)

 <img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/publicaciones_año.png">

Vertical lines mark presidential transitions.

2. With [Selenium](https://github.com/SeleniumHQ/selenium), simulate clicks on the ministry site to collect each document link for later download. Each notebook documents the flow with illustrative screenshots.

For this step you also need the ChromeDriver executable:
[Chromedriver for Selenium](https://chromedriver.chromium.org/)

The goal is to collect PDF URLs for all resolutions published on the ministry website and export them to Excel via a DataFrame.

### PDF download and text transcription

Download and transcription are also split: [Decree PDF download notebook](https://github.com/ccamilocristian/Scrapping_MinSalud/blob/master/Decretos/Descarga_PDFs_%26_Trasncripci%C3%B3n_decretos.ipynb) and [Resolution PDF download notebook](https://github.com/ccamilocristian/Scrapping_MinSalud/blob/master/Resoluciones/Descarga_PDFs_%26_Trasncripci%C3%B3n_resoluciones.ipynb).

Each script:

 1. Downloads every document listed on the ministry site using URLs from the scraping notebooks, via `urllib`.
 2. Transcribes PDFs to text and flags documents under 200 words—often scanned images—converting them to Word and re-exporting PDF when needed.

The output is a text DataFrame exported to Excel for analysis.

### Consolidation and cleaning

Using Pandas, NLTK, scikit-learn, and Matplotlib, the transcribed corpora are cleaned and enriched. Four keyword dictionaries were built for:

- Epidemics
- Coverage
- Intervention
- Fraud

---

## 2. Analysis

Full analysis code: [Analisis_textos.ipynb](https://github.com/ccamilocristian/MCPP_cristian.moreno/blob/master/Proyecto%20final/Analisis%20texto/Analisis_textos.ipynb)

<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/word_cloud.png">

Macro health indicators for Colombia came from:

1. Health spending and physicians/nurses per 1,000 inhabitants — [World Bank](https://datos.bancomundial.org/pais/colombia)
2. Coverage series — [Ministry of Health](https://www.minsalud.gov.co/proteccionsocial/Regimensubsidiado/Paginas/coberturas-del-regimen-subsidiado.aspx)

Coverage:
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/cobertura_año.png">
Figure 1.
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/gasto_salud_PIB.png">
Figure 2.
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/cobertura.png">
Figure 3.

Each vertical line marks a change of Health Minister. Figure 1 shows a rising trend in coverage-related language, with a sharp peak under Alejandro Gaviria's tenure—consistent with the coverage percentages in Figure 3 for both subsidized and contributory regimes.

Epidemics:
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/epidemias.png">
Figure 4.

Interventions:
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/intervenciones.png">
Figure 5.

Fraud and litigation:
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/fraude.png">
Figure 6.
<img src="/assets/img/2021-04-12-ministerio-salud/Imagenes/salud_per_capita.png">
Figure 7.

Despite rising coverage and document emphasis on that theme (Figures 1–3), decrees and resolutions also highlight interventions in public health institutions and fraud/litigation—especially after the *niña* phenomenon—suggesting sector inefficiencies and possible corruption. Figure 7 shows that although health spending as a share of GDP rose over 20 years, per-capita spending fell sharply in 2015.

Future work should investigate corruption and diversion of public funds.

--- 

Suggested follow-up research:

1. Analyze correlations and external effects such as corruption in this regulatory body.
2. Run causal analysis of inefficiency indicators at health centers by year and link them to intervention counts.
3. Study pensioner and subsidized enrollment dynamics over time and test statistical significance against coverage growth.
