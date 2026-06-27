---
title: "A Python MCP server that lets Cursor query BigQuery safely"
redirect_from:
  - /posts/mcp-bigquery-server-python/
author: Cristian Camilo Moreno Narvaez
date: 2026-06-27 10:00:00 -0500
categories: [Python, Machine Learning]
tags: [mcp, model-context-protocol, python, big-query, cursor-ide, data-engineering]
math: false
domain: Machine Learning
technical_level: Intermediate
reading_time: 12
business_impact: "Gives analytics teams a guarded path from IDE agents to warehouse tables—without pasting raw SQL into chat."
impact_label: "MCP BigQuery tools"
description: "Build a small MCP server in Python so Claude or Cursor can list tables and run parameterized BigQuery queries—with a byte cap and read-only SQL."
---

If you use **Cursor** or **Claude Desktop** next to your data stack, you have probably seen this: the model writes `SELECT *` on a huge table, or drifts into SQL you did not ask for.

**MCP** means **Model Context Protocol**. It is a small standard so an AI assistant can call **tools** you write—list a table, run a query, fetch a file—instead of guessing in chat.

**BigQuery** is Google’s data warehouse in the cloud. **GCP** is Google Cloud Platform, where the project and credentials live.

This tutorial builds **one Python 3 file** called `server.py`. The code blocks below are **pieces of that same file**, in order. At the end you get the **full file** to copy in one shot if you prefer.

There is also a short **bash** command to install libraries, and a **JSON** snippet for Cursor’s config file. Nothing else.

![Cursor talks to a Python MCP server, which queries BigQuery](/assets/img/mcp-bigquery/mcp-flow.png)
*Diagram: AI-assisted, cropped for this post.*

## Before you open the editor

You need:

1. Python **3.10+** installed (`python3 --version`).
2. A GCP project with BigQuery enabled.
3. A service account JSON key with read access to one dataset.

In the terminal (bash), point Python at that key:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your-key.json"
```

Install the two Python packages we use:

```bash
pip install mcp google-cloud-bigquery
```

Create an empty file next to where you keep scripts:

```text
server.py
```

Everything from here goes **inside** `server.py`, top to bottom.

---

## Part A — Settings (top of `server.py`)

Open `server.py` and paste this first block. Change `PROJECT` and `DATASET` to yours.

```python
# server.py — Python 3
import json
from google.cloud import bigquery
from mcp.server.fastmcp import FastMCP

PROJECT = "your-gcp-project"
DATASET = "analytics"
MAX_BYTES = 500_000_000   # ~500 MB max per query
MAX_ROWS = 200            # max rows sent back to the chat

client = bigquery.Client(project=PROJECT)
mcp = FastMCP("bigquery-tools")
```

---

## Part B — A simple SQL check (still in `server.py`)

Add these functions **below** Part A. They only allow read queries (`SELECT` / `WITH`).

```python
def sql_is_safe(query):
    q = query.strip().lower()
    if not (q.startswith("select") or q.startswith("with")):
        return False
    bad_words = ["insert ", "update ", "delete ", "drop ", "create ", "alter ", "merge "]
    return not any(w in q for w in bad_words)


def run_read_query(sql, params=None):
    if not sql_is_safe(sql):
        raise ValueError("Only read-only SELECT/WITH queries are allowed.")

    params = params or {}
    job_config = bigquery.QueryJobConfig(maximum_bytes_billed=MAX_BYTES)
    job_config.query_parameters = [
        bigquery.ScalarQueryParameter(name, "STRING", value)
        for name, value in params.items()
    ]

    rows = client.query(sql, job_config=job_config).result()
    out = []
    for row in rows:
        out.append(dict(row.items()))
        if len(out) >= MAX_ROWS:
            break
    return out
```

`maximum_bytes_billed` stops one heavy query from scanning too much data. `@dept` in SQL pairs with `params={"dept": "Antioquia"}`—do not paste user text straight into the query string.

---

## Part C — Three tools for Cursor (still in `server.py`)

Add this block **below** Part B. The `@mcp.tool()` lines register functions Cursor can call.

```python
@mcp.tool()
def list_tables():
    """Table names in the allowed dataset."""
    tables = client.list_tables(f"{PROJECT}.{DATASET}")
    return [t.table_id for t in tables]


@mcp.tool()
def describe_table(table_name):
    """Column names, types, and row count."""
    full_name = f"{PROJECT}.{DATASET}.{table_name}"
    t = client.get_table(full_name)
    columns = [{"name": f.name, "type": f.field_type} for f in t.schema]
    return {"table": full_name, "rows": t.num_rows, "columns": columns}


@mcp.tool()
def run_query(sql, params_json="{}"):
    """Read-only SQL. params_json example: {\"dept\": \"Antioquia\"}."""
    params = json.loads(params_json) if params_json else {}
    rows = run_read_query(sql, params)
    return {"row_count": len(rows), "rows": rows}
```

Test the file from bash:

```bash
python3 server.py
```

If it starts without errors, you are fine. Stop it with `Ctrl+C`.

---

## Full `server.py` (copy-paste version)

If you would rather not assemble parts, here is the **complete Python file**:

```python
# server.py — Python 3
import json
from google.cloud import bigquery
from mcp.server.fastmcp import FastMCP

PROJECT = "your-gcp-project"
DATASET = "analytics"
MAX_BYTES = 500_000_000
MAX_ROWS = 200

client = bigquery.Client(project=PROJECT)
mcp = FastMCP("bigquery-tools")


def sql_is_safe(query):
    q = query.strip().lower()
    if not (q.startswith("select") or q.startswith("with")):
        return False
    bad_words = ["insert ", "update ", "delete ", "drop ", "create ", "alter ", "merge "]
    return not any(w in q for w in bad_words)


def run_read_query(sql, params=None):
    if not sql_is_safe(sql):
        raise ValueError("Only read-only SELECT/WITH queries are allowed.")
    params = params or {}
    job_config = bigquery.QueryJobConfig(maximum_bytes_billed=MAX_BYTES)
    job_config.query_parameters = [
        bigquery.ScalarQueryParameter(name, "STRING", value)
        for name, value in params.items()
    ]
    rows = client.query(sql, job_config=job_config).result()
    out = []
    for row in rows:
        out.append(dict(row.items()))
        if len(out) >= MAX_ROWS:
            break
    return out


@mcp.tool()
def list_tables():
    tables = client.list_tables(f"{PROJECT}.{DATASET}")
    return [t.table_id for t in tables]


@mcp.tool()
def describe_table(table_name):
    full_name = f"{PROJECT}.{DATASET}.{table_name}"
    t = client.get_table(full_name)
    columns = [{"name": f.name, "type": f.field_type} for f in t.schema]
    return {"table": full_name, "rows": t.num_rows, "columns": columns}


@mcp.tool()
def run_query(sql, params_json="{}"):
    params = json.loads(params_json) if params_json else {}
    rows = run_read_query(sql, params)
    return {"row_count": len(rows), "rows": rows}
```

Parts A–C and this block are the **same code**—use whichever path is easier for you.

---

## Connect Cursor (JSON config, not Python)

Create or edit `~/.cursor/mcp.json`. This file is **JSON**, not Python:

```json
{
  "mcpServers": {
    "bigquery-tools": {
      "command": "python3",
      "args": ["/full/path/to/server.py"],
      "env": {
        "GOOGLE_APPLICATION_CREDENTIALS": "/full/path/to/key.json"
      }
    }
  }
}
```

Restart Cursor. In the MCP tools panel you should see `list_tables`, `describe_table`, and `run_query`.

Try a small prompt first: *“Use describe_table on my_table”*. Then a narrow `SELECT` with a `WHERE` clause.

---

## Example query (Python, optional test)

You can test `run_read_query` in a separate short script or a notebook—still Python:

```python
sql = """
SELECT school_id, avg_score
FROM `{project}.{dataset}.scores`
WHERE department = @dept
LIMIT 50
""".format(project=PROJECT, dataset=DATASET)

rows = run_read_query(sql, params={"dept": "Cundinamarca"})
print(rows[:3])
```

Replace table and column names with yours.

---

## How this fits the rest of the site

The [ICFES + BigQuery post](/posts/icfes-english/) shows how to load data. This post is the read path when an **LLM** (large language model) sits in the IDE.

## Limits

- **IAM** (who the service account can see) still rules access—not this script.
- The SQL check blocks obvious mistakes, not every attack.
- This setup is for your machine. Shared servers need extra auth later.
