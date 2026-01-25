# Week 6 Exercises: File Processing & Web Scraping

## Task Overview
Choose one of the following options to practice file processing and web scraping.

### Option 1: News Scraper to CSV
**Goal:** Scrape news and save to a file.
1. Use the **HTTP Request Node** to fetch the HTML of a news website (e.g., `https://news.ycombinator.com/`).
2. Use the **HTML Extract Node** to get the titles and links of the top 10 stories.
3. Use the **Spreadsheet File Node** to convert the JSON data into a CSV file.
4. Save the CSV file to a local directory or send it as a Telegram document.

### Option 2: PDF Text Extractor (OCR)
**Goal:** Extract text from a PDF file.
1. Create a workflow that triggers when a user sends a PDF file to a Telegram bot.
2. Use an external OCR API (like `OCR.space` or `Google Vision`) via the **HTTP Request Node** to extract text from the PDF.
3. Send the extracted text back to the user in Telegram.

### Option 3: Price Monitor
**Goal:** Scrape a specific price and alert on changes.
1. Choose an e-commerce page (e.g., a product on Amazon or a local store).
2. Use the **HTTP Request Node** and **HTML Extract Node** to get the current price.
3. Store the price in a database.
4. Run the workflow every hour (Cron) and send a Telegram alert if the price drops.

### Option 4: Certificate Generator
**Goal:** Generate a custom PDF certificate.
1. Create a workflow that triggers via a Webhook with user data (`name`, `course_name`, `date`).
2. Use an HTML-to-PDF service or a specialized n8n node to generate a PDF certificate using an HTML template.
3. Send the generated PDF to the user via Telegram or Email.

### Option 5: Image Format Converter
**Goal:** Convert images between formats.
1. Create a workflow that triggers when a user sends a PNG image to a Telegram bot.
2. Use a tool or API to convert the PNG image to JPEG.
3. Send the converted JPEG image back to the user.

## Submission
- Export your workflow as a `.json` file.
- Save it in this folder as `week-6-solution.json`.
