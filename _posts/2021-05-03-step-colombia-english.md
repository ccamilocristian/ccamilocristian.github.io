---
title: Colombian labor market — STEP program case study
redirect_from:
  - /posts/step-colombia/
  - /step-colombia-english/
author: Cristian Camilo Moreno Narvaez
date: 2021-05-03 15:00:00 -0500
categories: [Python, Economics]
tags: [economics, python, regression]
math: true
domain: Economics
technical_level: Advanced
reading_time: 16
business_impact: "Improved policy interpretation by connecting statistical outputs with economic decision logic."
impact_label: "STEP labor-market automation risk"
description: "Colombia's STEP survey plus Frey & Osborne: regressions to adjust automation risk by age, gender, education, and job skills."
---
Job automation reflects the adoption of new technologies in firm value chains. That structural shift has both positive and negative labor-market effects. Frey & Osborne's 2017 study, *The future of employment: How susceptible are jobs to computerisation?*, is a common starting point for estimating automation risk. The authors used machine learning to estimate, at the occupation level, the probability of automation within ten years in the United States.

![ ](/assets/img/2021-05-03-step-colombia/pexels-alex-knight-2599244.jpg)

Following Bustelo et al. (2020), this post adapts that framework to Colombia using Frey & Osborne (2017) benchmarks and microdata from the World Bank [STEP](https://microdata.worldbank.org/index.php/catalog/2012) survey (*Skills Toward Employment and Productivity*) to measure skills associated with specific occupations.

The adjusted probabilities help assess how current occupations—and economic sectors—might respond to technology shocks, especially robotics.

STEP was fielded in 2012 across 13 metropolitan areas in Colombia with 1,550 respondents, covering:

+ Household demographics
+ Housing
+ Health
+ Employment
+ Job skills
+ Personality, behavior, and preferences
+ Language and family background
+ Reading assessment

# Variable construction

Model variables are defined as follows:

| Syntax      | Description |
| :-----------: | ----------- |
| ICT digital      | Information and communication technology skills       |
| Management and communication  | Management and communication skills |
| Readiness to learn and creativity        | Willingness to learn and creative problem-solving |
| Self-organization      | Self-organization skills |
| Marketing and accounting      | Marketing and accounting skills       |
| Physical      | Physically demanding work skills       |
| STEM quantitative | Science, technology, engineering, and math skills |

Measures are standardized with z-scores to align scales. To merge STEP with Frey & Osborne automation risk, occupations are mapped using SOC (6-digit Standard Occupational Classification) to U.S. ISCO (3-digit International Standard Classification of Occupations).

![ ](/assets/img/2021-05-03-step-colombia/correlacion.PNG)



|Variables|Mean|Std. dev.|
|---|---|---|
|ICT|-0.01479|0.990889|
|Management & Communication|-0.015207|0.99609|
|Readiness to learn & Creativity|-0.004358|1.001575|
|Self-Organization|-0.002029|1.002626|
|Marketing and Accounting|0.007716|0.998354|
|STEM quantitative|-0.006013|0.997693|
|Physical|0.001656|1.002446|
|Socioeconomic stratum|2.395484|0.902821|
|Gender|0.500645|0.500161|
|Age|35.630323|11.619844|
|Higher education|0.342581|0.474726|
|Automation risk|0.628414|0.247711|

![ ](/assets/img/2021-05-03-step-colombia/edad1.png)

The age distribution is left-skewed with a mean of 35 years, as shown in the summary table.

![ ](/assets/img/2021-05-03-step-colombia/estrato1.png)

The sample concentrates in strata 2 and 3, which is not nationally representative. Weighting with surveys such as DANE's GEIH (*Gran Encuesta Integrada de Hogares*), which provides expansion factors, would improve external validity.

# Model specification

The estimated model:

$$ y_i= \sum_{n=1}^{N}\beta_{n}*X_{in} + \varepsilon_{i} $$

where $$y$$ is automation risk for the occupation in which worker $$i$$ is employed and $$X_n $$ captures seven skill measures, education, age group, and gender. $$N$$ is the number of regressors.

![ ](/assets/img/2021-05-03-step-colombia/ModeloSTEP.PNG)

# Results

## Age

Adjusted probabilities are highest for workers aged 18–25, followed by 26–40. That may reflect task specialization and higher education among older workers.

![ ](/assets/img/2021-05-03-step-colombia/ries_edad.png)

## Gender

Women show higher adjusted automation probability. Deeper analysis should map occupations and skill profiles by gender to inform inclusive labor policy.

![ ](/assets/img/2021-05-03-step-colombia/genero.png)

## Education

Higher education levels associate with lower automation risk—as expected. Because the sample is not nationally representative, preschool results in particular should be interpreted cautiously. Researchers such as David Autor link automation and education to [polarization](https://www.stlouisfed.org/publications/regional-economist/january-2013/job-polarization-leaves-middleskilled-workers-out-in-the-cold#:~:text=An%20important%20point%20Autor%20made,pronounced%20during%20the%20Great%20Recession.), where middle-skill workers face the largest displacement from new technologies.

![ ](/assets/img/2021-05-03-step-colombia/ries_edu.png)

## Overall comparison

The chart below compares Frey & Osborne occupation-level risks for STEP occupations against model-adjusted probabilities.

![ ](/assets/img/2021-05-03-step-colombia/vs.png)

The gap reflects methodological differences: a **task-based** approach captures variation in tasks within occupations, while Frey & Osborne's **occupation-based** approach assigns the same risk to all workers in an occupation. Task-based models argue that specific tasks—not entire occupations—are displaced by machines.

More research is needed on automation impacts in developing economies, especially Colombia. A future post will review the state of automation research in Colombia and call for action to mitigate displacement from robots and autonomous learning algorithms.

# References
+ Frey, C. B., & Osborne, M. A. (2017). “The future of employment: How susceptible are jobs to computerisation? Technological Forecasting and Social Change”, 114, 254–280.
+ Bustelo, M., Egana-delSol, P., Ripani, L., Nicolas, S., & Viollaz, M. (2020). "Automation in Latin America: Are Women at Higher Risk of Losing Their Jobs?" Inter-American Development Bank.
