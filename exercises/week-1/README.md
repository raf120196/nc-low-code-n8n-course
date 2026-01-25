# Week 1 Practice: Low-Code Fundamentals & Environment Setup

Choose **one** of the following options to complete for this week's practice.

## Option 1: Basic Webhook Response
**Goal:** Deploy n8n and create a Webhook-triggered workflow that returns a personalized greeting.
- **Trigger:** Webhook node (HTTP Method: GET).
- **Logic:** Use an expression to read a query parameter named `name`.
- **Action:** Respond with "Hello, [Name]!". If no name is provided, respond with "Hello, Stranger!".

## Option 2: Cron Logger
**Goal:** Set up n8n and create a workflow that logs the current timestamp to the console.
- **Trigger:** Schedule node (Cron: every minute).
- **Action:** Use a "No-Op" or "Code" node to output the current date and time.
- **Verification:** Check the "Executions" tab to see the logs.

## Option 3: Simple HTML Status Page
**Goal:** Create a workflow that triggers via HTTP GET and returns a simple HTML page.
- **Trigger:** Webhook node (HTTP Method: GET).
- **Action:** Use the "Respond to Webhook" node.
- **Content:** Set the response body to a simple HTML string: `<html><body><h1>System Status: OK</h1></body></html>`.

## Option 4: Telegram Echo Bot
**Goal:** Connect a Telegram bot and create a workflow that echoes back any text message.
- **Prerequisite:** Create a bot via [@BotFather](https://t.me/botfather) and get the API Token.
- **Trigger:** Telegram Trigger node.
- **Action:** Telegram node (Action: Send Message).
- **Logic:** Send the same text received from the trigger back to the user.

## Option 5: Webhook Forwarder
**Goal:** Create a workflow that triggers on a Webhook and sends a POST request with the same data to a test endpoint.
- **Trigger:** Webhook node (HTTP Method: POST).
- **Action:** HTTP Request node.
- **Logic:** Forward the received JSON body to `https://webhook.site` (generate your unique URL there).

---

### Submission Instructions
1. Export your workflow as a `.json` file.
2. Name it `week-1-option-X.json` (replace X with your choice).
3. Place it in the `exercises/week-1/` folder.
