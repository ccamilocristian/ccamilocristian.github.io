---
title: Real cost of credit in Colombia — amortization, Fisher, and CPI
redirect_from:
  - /real-cost-of-credit-colombia-english/
author: Cristian Camilo Moreno Narvaez
date: 2026-07-19 01:15:00 -0500
lastmod: 2026-07-19 01:15:00 -0500
categories: [Python, Economics]
tags: [economics, python, credit, amortization, inflation, colombia]
math: true
domain: Economics
technical_level: Intermediate
reading_time: 7
business_impact: "Separates nominal loan payments from their inflation-adjusted burden."
impact_label: "Nominal and real credit cost"
description: "Build a fixed-payment amortization table in Python, estimate the real rate with Fisher, and express payments in constant pesos."
---

A quoted loan rate describes nominal cash flows. It does not show how the
payment burden changes after inflation. This note connects three views of the
same Colombian credit decision: the fixed payment, the amortization table, and
payments expressed in constant pesos.

## Part A — fixed-payment amortization

For principal \(P\), monthly rate \(i\), and \(n\) payments:

$$
A=P\frac{i(1+i)^n}{(1+i)^n-1}
$$

```python
import pandas as pd


def monthly_rate(effective_annual_rate: float) -> float:
    return (1 + effective_annual_rate) ** (1 / 12) - 1


def amortization(
    principal: float,
    effective_annual_rate: float,
    months: int,
) -> pd.DataFrame:
    rate = monthly_rate(effective_annual_rate)
    payment = principal * rate * (1 + rate) ** months / ((1 + rate) ** months - 1)
    balance = principal
    rows = []

    for month in range(1, months + 1):
        interest = balance * rate
        principal_paid = payment - interest
        closing_balance = max(0.0, balance - principal_paid)
        rows.append(
            {
                "month": month,
                "opening_balance": balance,
                "payment": payment,
                "interest": interest,
                "principal": principal_paid,
                "closing_balance": closing_balance,
            }
        )
        balance = closing_balance

    return pd.DataFrame(rows)


schedule = amortization(
    principal=20_000_000,
    effective_annual_rate=0.18,
    months=36,
)
print(schedule.head())
```

Treat fees, insurance, taxes, and changing rates as separate cash flows. Leaving
them out understates the effective cost.

## Part B — the Fisher real rate

The exact relationship between a nominal annual rate \(i\), expected inflation
\(\pi\), and real rate \(r\) is:

$$
1+r=\frac{1+i}{1+\pi}
$$

```python
def fisher_real_rate(nominal_rate: float, inflation_rate: float) -> float:
    return (1 + nominal_rate) / (1 + inflation_rate) - 1


real_rate = fisher_real_rate(0.18, 0.0614)
print(f"{real_rate:.2%}")
```

The inflation input is an assumption when evaluating future payments. Label the
scenario; do not present the latest annual CPI variation as a forecast.

## Part C — payments in constant pesos

After payments occur, deflate each one with the monthly CPI index:

```python
def add_real_payments(
    schedule: pd.DataFrame,
    monthly_cpi: pd.Series,
    base_month: str,
) -> pd.DataFrame:
    result = schedule.copy()
    base = pd.Period(base_month, freq="M")
    if len(result) > len(monthly_cpi.loc[base:]):
        raise ValueError("The CPI series does not cover every payment month")

    observations = monthly_cpi.loc[base:].iloc[: len(result)]
    result["cpi_month"] = observations.index.astype(str)
    result["cpi"] = observations.to_numpy()
    result["real_payment_base_month"] = (
        result["payment"] * float(monthly_cpi.loc[base]) / result["cpi"]
    )
    return result
```

Use the validated monthly series from the [Colombia CPI indexation
engine](/posts/colombia-cpi-indexation-engine-english/). This historical view
answers how the realized burden evolved. A forward decision needs multiple
inflation scenarios rather than one point estimate.

## Decision checks

1. Compare the lender's quoted rate on the same basis: nominal annual,
   effective annual, or monthly.
2. Add mandatory fees and insurance to the cash-flow schedule.
3. Report nominal payment, total nominal interest, and real-rate scenario
   separately.
4. Stress-test income and inflation instead of assuming both move together.
5. Preserve inputs and outputs as a CSV when the analysis supports a decision.

## Related on this site

- [Colombia CPI indexation engine](/posts/colombia-cpi-indexation-engine-english/)
  — validated monthly IPC and audit trail.
- [Original loan simulator](/posts/loan-simulator-english/) — a visual,
  introductory amortization implementation.
- [Consumer optimization in Python](/posts/optimation-consumer-english/) —
  constraints and tradeoffs.
