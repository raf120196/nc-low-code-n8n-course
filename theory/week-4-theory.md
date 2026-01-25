# Week 4: Data Persistence (Databases & Sheets)

## Overview
Automations often need to store and retrieve data. This week, we explore how to use external storage solutions like PostgreSQL databases and Google Sheets to maintain state and persist information.

## 1. Relational Databases (PostgreSQL)
PostgreSQL is a powerful, open-source relational database.
- **Tables:** Where data is stored in rows and columns.
- **CRUD Operations:**
  - **Create:** Inserting new rows into a table.
  - **Read:** Querying data from a table (SELECT).
  - **Update:** Modifying existing rows.
  - **Delete:** Removing rows.
- **SQL (Structured Query Language):** The language used to interact with the database.

## 2. Google Sheets as a Database
For simpler use cases, Google Sheets can act as a lightweight, visual database.
- **Pros:** Easy to view and edit manually, no setup required.
- **Cons:** Slower than real databases, limited row capacity, not suitable for complex relationships.

## 3. n8n Database Nodes
n8n provides dedicated nodes for various databases:
- **Postgres Node:** Allows you to execute SQL queries or use a visual builder for CRUD operations.
- **Google Sheets Node:** Supports reading, appending, updating, and deleting rows in a spreadsheet.

## 4. When to Use What?
- Use **PostgreSQL** for: Large datasets, complex queries, high-performance needs, and production applications.
- Use **Google Sheets** for: Prototyping, small internal tools, and when non-technical users need to see/edit the data.

## Recommended Reading
- [Postgres Node Documentation](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.postgres/)
- [Google Sheets Node Documentation](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.googlesheets/)
- [SQL Basics for n8n Users](https://www.w3schools.com/sql/)
