---
title: Colombia CPI indexation in Python — monthly IPC and an audit trail
redirect_from:
  - /colombia-cpi-indexation-engine-english/
author: Cristian Camilo Moreno Narvaez
date: 2026-07-19 01:00:00 -0500
lastmod: 2026-07-19 01:00:00 -0500
categories: [Python, Economics]
tags: [economics, python, ipc, inflation, colombia, dane, audit]
math: true
domain: Economics
technical_level: Intermediate
reading_time: 8
business_impact: "Makes inflation adjustments reproducible, reviewable, and tied to official Colombian data."
impact_label: "Monthly CPI indexation with an audit trail"
description: "Index Colombian peso values with official monthly IPC data in Python, validate the series, and export a calculation audit trail."
---

A **calculadora de inflación Colombia** is useful only when its source, reference
months, and formula are visible. This implementation turns the official monthly
Colombian consumer price index—IPC in Spanish, CPI in English—into a small
Python function and an audit CSV.

The result answers questions such as “what is a January 2014 amount worth in
June 2026 pesos?” without hiding the index observations used in the calculation.

## The decision rule

For an amount \(V_0\), an origin month \(t_0\), and a target month \(t_1\):

$$
V_1 = V_0 \times \frac{IPC_{t_1}}{IPC_{t_0}}
$$

This is indexation, not a forecast. It compares purchasing-power reference
points from the published series; it does not estimate future inflation.

## Part A — obtain the official series

[DANE calculates and certifies Colombia's CPI](https://www.dane.gov.co/index.php/estadisticas-por-tema/precios-y-costos/indice-de-precios-al-consumidor-ipc/ipc-informacion-tecnica).
Its technical page publishes the current workbook and historical series. The
[Banco de la República economic statistics portal](https://suameca.banrep.gov.co/estadisticas-economicas/informacionSerie/100002/indice_de_precios_al_consumidor_ipc/)
provides the national monthly index as a convenient official-series catalog.

Download the current DANE “Índices - series de empalme” workbook and retain the
original file beside the transformed output. In June 2026, DANE reported a
monthly change of 0.39%, year-to-date change of 4.77%, and annual change of
6.14%; use the workbook—not those headline rates—for month-to-month indexation.

The workbook layout can change. Export the national total series to a tidy CSV
with these two columns:

```text
date,cpi
2003-03-01,...
...
2026-06-01,...
```

Keep the decimal index values exactly as published. Do not round until the final
money result.

## Part B — validate and index

```python
from __future__ import annotations

from dataclasses import asdict, dataclass
from pathlib import Path

import pandas as pd


@dataclass(frozen=True)
class IndexationResult:
    amount_cop: float
    from_month: str
    to_month: str
    from_cpi: float
    to_cpi: float
    factor: float
    indexed_amount_cop: float


def load_cpi(path: str | Path) -> pd.Series:
    frame = pd.read_csv(path)
    required = {"date", "cpi"}
    if not required.issubset(frame.columns):
        raise ValueError(f"Expected columns: {sorted(required)}")

    frame["date"] = pd.to_datetime(frame["date"]).dt.to_period("M")
    frame["cpi"] = pd.to_numeric(frame["cpi"], errors="raise")
    frame = frame.sort_values("date")

    if frame["date"].duplicated().any():
        duplicates = frame.loc[frame["date"].duplicated(), "date"].astype(str)
        raise ValueError(f"Duplicate CPI months: {duplicates.tolist()}")
    if (frame["cpi"] <= 0).any():
        raise ValueError("CPI observations must be positive")

    expected = pd.period_range(frame["date"].min(), frame["date"].max(), freq="M")
    missing = expected.difference(frame["date"])
    if len(missing):
        raise ValueError(f"Missing CPI months: {missing.astype(str).tolist()}")

    return frame.set_index("date")["cpi"]


def index_value(
    amount_cop: float,
    from_month: str,
    to_month: str,
    cpi: pd.Series,
) -> IndexationResult:
    origin = pd.Period(from_month, freq="M")
    target = pd.Period(to_month, freq="M")
    from_cpi = float(cpi.loc[origin])
    to_cpi = float(cpi.loc[target])
    factor = to_cpi / from_cpi

    return IndexationResult(
        amount_cop=amount_cop,
        from_month=str(origin),
        to_month=str(target),
        from_cpi=from_cpi,
        to_cpi=to_cpi,
        factor=factor,
        indexed_amount_cop=round(amount_cop * factor, 2),
    )


cpi = load_cpi("dane_colombia_cpi_monthly.csv")
result = index_value(
    amount_cop=3_000_000,
    from_month="2014-01",
    to_month="2026-06",
    cpi=cpi,
)
print(asdict(result))
```

The validation is intentionally strict. A missing month, duplicate observation,
or text value should stop the calculation instead of silently producing a
plausible number.

## Part C — export the audit trail

An output amount alone is hard to review. Export the two source observations,
formula factor, source URL, and calculation timestamp:

```python
from datetime import datetime, timezone

audit = pd.DataFrame(
    [
        {
            **asdict(result),
            "formula": "amount_cop * to_cpi / from_cpi",
            "source": (
                "https://www.dane.gov.co/index.php/estadisticas-por-tema/"
                "precios-y-costos/indice-de-precios-al-consumidor-ipc/"
                "ipc-informacion-tecnica"
            ),
            "calculated_at_utc": datetime.now(timezone.utc).isoformat(),
        }
    ]
)
audit.to_csv("colombia_cpi_indexation_audit.csv", index=False)
```

For a production workflow, also store the original workbook's filename and
SHA-256 checksum. That makes it possible to reproduce the result after DANE
publishes a newer month.

## Checks before using the result

1. Confirm both dates are months represented in the official series.
2. Record whether the target month is final or provisional.
3. Keep full-precision index observations and round only Colombian pesos.
4. Do not substitute annual inflation rates for monthly index levels.
5. State the reference month in reports; “2026 pesos” is less precise than
   “June 2026 pesos.”

## Related on this site

- [Earlier annual CPI calculator](/posts/convertidor-english/) — the original
  2003–2020 implementation and formula.
- [Consumer optimization in Python](/posts/optimation-consumer-english/) —
  budget constraints and inspectable tradeoffs.
- [Loan interest simulator](/posts/loan-simulator-english/) — nominal credit
  cash flows that can be connected to real peso values.
- Explore the Economics collection in [Intelligence](/tabs/intelligence/).
