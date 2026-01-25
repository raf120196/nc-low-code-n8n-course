# Week 6: File Processing & Web Scraping

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
- [n8n Course: Advanced Data Transformation](https://academy.n8n.io/courses/advanced-data-transformation)
