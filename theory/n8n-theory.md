# Chapter 1: Low-Code Fundamentals & Environment Setup

## 1. Introduction to Low-Code/No-Code
Low-code is a software development approach that requires little to no coding to build applications and processes. Instead of using complex programming languages, you use visual interfaces with basic logic and drag-and-drop capabilities.

### Why Low-Code?
- **Speed:** Build and deploy workflows much faster than traditional coding.
- **Accessibility:** Enables non-developers (Business Analysts, Marketers) to build solutions.
- **Cost-Effective:** Reduces the need for large development teams for internal tools.

## 2. What is n8n?
n8n is an extendable workflow automation tool. It allows you to connect various SaaS tool APIs, databases, and internal tools without writing much code.

### Core Concepts:
- **Nodes:** The building blocks of a workflow. Each node performs a specific action (e.g., sending an email, fetching data from a database).
- **Connections:** The lines connecting nodes, representing the flow of data.
- **Triggers:** Special nodes that start a workflow (e.g., a Webhook, a Cron schedule, or a new message in Telegram).
- **Actions:** Nodes that perform a task after being triggered.

## 3. n8n Architecture
n8n can be hosted in several ways:
- **n8n Cloud:** Managed service by n8n.
- **Self-Hosted (Docker/Podman):** Running n8n on your own infrastructure using containers.
- **Desktop App:** A simplified version for local testing.

## 4. Environment Setup (Self-Hosting with Podman)
In this course, we focus on self-hosting using Podman (an open-source alternative to Docker).

### Prerequisites:
- Podman Desktop installed.
- `podman-compose` or `docker-compose` compatibility.

### Basic Setup:
Detailed instructions for deploying n8n via Podman, configuring environment variables, and importing the test workflow can be found in the root [README.md](../README.md).

Quick steps:
1. Clone the repository.
2. Configure your `.env` file based on `n8n.env.example`.
3. Start n8n:
   ```bash
   podman-compose up -d
   ```
4. Import the example workflow from the `workflows/` folder as described in [README.md](../README.md#import-workflow-example).

## 5. Resources
- [n8n Documentation: Core nodes](https://docs.n8n.io/integrations/builtin/core-nodes/)
- [What is iPaaS (Gartner)](https://www.gartner.com/en/information-technology/glossary/platform-as-a-service-ipaas)
- [Podman Desktop Documentation](https://podman-desktop.io/docs/intro)

# Chapter 2: Data Manipulation & Logic (Core Nodes)

## Overview
In this module, you will learn how to handle, transform, and route data within n8n workflows. Understanding data structures and core nodes is essential for building complex automations.

## 1. Data Types in n8n
n8n primarily works with two types of data:
- **JSON (JavaScript Object Notation):** The standard format for structured data (objects, arrays, strings, numbers).
- **Binary:** Used for files (images, PDFs, documents).

## 2. Core Nodes for Data Manipulation
- **Edit Fields (Set):** Used to add, remove, or modify fields in the JSON data.
- **Filter:** Allows you to continue the workflow only if certain conditions are met.
- **Switch:** Routes data to different paths based on specific values or conditions.
- **Code Node:** Allows you to write custom JavaScript to perform complex data transformations that are difficult to achieve with standard nodes.

## 3. n8n Expressions
Expressions allow you to dynamically access data from previous nodes.
- Syntax: `{{ $json.field_name }}`
- You can use JavaScript methods within expressions, e.g., `{{ $json.name.toUpperCase() }}`.

## 4. Data Structure
n8n processes data as an array of objects. Each object in the array represents one "item" that flows through the nodes.

## Recommended Reading
- [n8n Expressions Guide](https://docs.n8n.io/code/expressions/)
- [Data structure in n8n](https://docs.n8n.io/concepts/data-structure/)
- [JavaScript for n8n (Code Node)](https://docs.n8n.io/code/javascript-examples/)

# Chapter 3: External APIs & Messaging

## Overview
This week focuses on connecting n8n to the outside world using REST APIs and messaging platforms like Telegram. You will learn how to fetch data from external services and send automated messages.

## 1. REST API Basics
REST (Representational State Transfer) is the standard way for web services to communicate.
- **HTTP Methods:**
  - `GET`: Retrieve data.
  - `POST`: Send data to create something new.
  - `PUT`/`PATCH`: Update existing data.
  - `DELETE`: Remove data.
- **Status Codes:**
  - `200 OK`: Success.
  - `201 Created`: Successfully created a resource.
  - `400 Bad Request`: Client-side error.
  - `401 Unauthorized`: Authentication failed.
  - `404 Not Found`: Resource not found.
  - `500 Internal Server Error`: Server-side error.

## 2. Authentication
Most APIs require authentication to ensure security.
- **Header Auth:** Passing a token in the `Authorization` header.
- **Query Auth:** Passing an API key as a URL parameter.
- **OAuth2:** A more complex but secure standard for authorization.

## 3. Telegram Bot API
Telegram is a popular platform for building bots. In n8n, you can use the **Telegram Node** to:
- Send text messages, images, and documents.
- Receive messages via Webhooks.
- Create interactive buttons.

## 4. Webhooks vs. Polling
- **Webhooks:** The external service "pushes" data to n8n as soon as an event occurs (Real-time).
- **Polling:** n8n "pulls" data from the service at regular intervals (e.g., every 5 minutes).

## Recommended Reading
- [HTTP Request Node Guide](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.httprequest/)
- [Telegram Node Documentation](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.telegram/)
- [Postman: What is a REST API?](https://www.postman.com/api-platform/what-is-a-rest-api/)

# Chapter 4: Data Persistence (Databases & Sheets)

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

# Chapter 5: Error Handling & Advanced Logic

## Overview
Even the best-designed workflows can fail. This week, you will learn how to make your automations resilient by implementing error handling, retries, and modular logic using sub-workflows.

## 1. Error Handling in n8n
- **Error Trigger Node:** A special trigger that fires whenever another workflow fails. It provides details about the error (node name, error message, etc.).
- **Error Workflow:** A dedicated workflow that handles errors from multiple other workflows (e.g., sending a notification to Slack/Telegram when something breaks).
- **Node-Level Settings:** You can configure individual nodes to "Continue on Fail" or "On Error -> Stop Workflow / Continue".

## 2. Resilience Patterns
- **Retry Mechanism:** Automatically attempting an operation again if it fails (e.g., if an API is temporarily down).
- **Wait Node:** Pausing the workflow for a specific amount of time (seconds, minutes, hours) or until a specific date/time.

## 3. Modular Workflows
- **Execute Workflow Node:** Allows you to call one workflow from another. This is useful for:
  - Reusing common logic (e.g., a "Send Notification" sub-workflow).
  - Breaking down large, complex workflows into smaller, manageable pieces.
  - Organizing logic into "Master" and "Worker" workflows.

## 4. Advanced Logic & Security
- **Environment Variables:** Storing configuration and secrets outside of the workflow itself.
- **Rate Limiting:** Ensuring your workflow doesn't exceed the limits of external APIs.

## Recommended Reading
- [Error handling in n8n](https://docs.n8n.io/hosting/scaling-monitoring/error-handling/)
- [Wait Node Documentation](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.wait/)
- [Execute Workflow Node](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.executeworkflow/)
- [n8n Best Practices: Error Handling](https://n8n.io/blog/error-handling-in-n8n/)

# Chapter 6: File Processing & Web Scraping

## Overview
Automations often involve more than just JSON data. This week, we dive into handling files (binary data) and extracting information from websites (web scraping).

## 1. Binary Data in n8n
Binary data refers to files like images, PDFs, spreadsheets, and documents.
- **Binary Property:** In n8n, binary data is stored in a special property (usually named `data`).
- **Read/Write Binary File Nodes:** Used to read files from or write files to the local filesystem.
- **Convert to/from Binary:** Nodes like **Spreadsheet File** or **Move Binary Data** help convert between JSON and binary formats.

## 2. Web Scraping & HTML Parsing
Web scraping is the process of extracting data from websites.
- **HTTP Request Node:** Used to fetch the raw HTML content of a webpage.
- **HTML Extract Node:** Uses CSS selectors (like `.title` or `#price`) to extract specific elements from the HTML.
- **Regular Expressions (Regex):** A powerful way to find and extract patterns in text (e.g., email addresses, phone numbers).

## 3. File Generation
n8n can generate files dynamically:
- **CSV/Excel:** Converting JSON arrays into spreadsheet files.
- **PDF:** Using HTML templates to generate documents like invoices or certificates.

## 4. OCR (Optical Character Recognition)
OCR allows you to extract text from images or scanned PDFs. While n8n doesn't have a built-in OCR engine, you can easily integrate with external OCR APIs (like Tesseract or Google Vision) via the **HTTP Request Node**.

## Recommended Reading
- [Binary data in n8n](https://docs.n8n.io/concepts/binary-data/)
- [HTML Extract Node Guide](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.htmlextract/)
- [Regex101: Testing Regular Expressions](https://regex101.com/)
