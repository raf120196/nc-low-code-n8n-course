# Week 4 Exercises: Data Persistence

## Task Overview
Choose one of the following options to practice working with databases and Google Sheets.

### Option 1: Message Logger (PostgreSQL)
**Goal:** Save Telegram messages to a database.
1. Set up a PostgreSQL database (e.g., using Docker or a free cloud provider like Supabase).
2. Create a table `messages` with columns: `user_id` (Integer), `message_text` (Text), and `received_at` (Timestamp).
3. Create an n8n workflow that triggers on a Telegram message and inserts the data into the `messages` table.

### Option 2: Newsletter Sender (Google Sheets)
**Goal:** Send personalized messages from a spreadsheet.
1. Create a Google Sheet with a list of "Subscribers" (Name, Telegram ID).
2. Create an n8n workflow that reads all rows from the sheet.
3. Use the **Telegram Node** to send a personalized "Good Morning, [Name]!" message to each subscriber.

### Option 3: Inventory Manager
**Goal:** Update a database via Telegram.
1. Create a table `inventory` with `item_name` and `quantity`.
2. Build a workflow where a user sends a message like "Update: Apples, 10".
3. Use a **Code Node** or **Edit Fields** to parse the message and update the corresponding row in the database.

### Option 4: Weekly Log Export
**Goal:** Export database logs to Google Sheets.
1. Create a workflow that triggers every Sunday at midnight (Cron).
2. Fetch all entries from a PostgreSQL table.
3. Append all fetched entries into a Google Sheet as a backup/report.

### Option 5: Feedback Collector
**Goal:** Collect feedback via Webhook and store it.
1. Create a simple HTML form or use a tool like Webhook.site to send a POST request with feedback data (`user`, `rating`, `comment`).
2. Store the feedback in a database table.
3. Send a summary of the feedback to a manager via Telegram.

## Submission
- Export your workflow as a `.json` file.
- Save it in this folder as `week-4-solution.json`.
