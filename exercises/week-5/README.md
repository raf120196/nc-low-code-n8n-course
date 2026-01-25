# Week 5 Exercises: Error Handling & Advanced Logic

## Task Overview
Choose one of the following options to practice error handling and advanced workflow logic.

### Option 1: Error Notification System
**Goal:** Create a dedicated error handling workflow.
1. Create a "Main Workflow" that intentionally fails (e.g., tries to call a non-existent API).
2. Create an "Error Workflow" triggered by the **Error Trigger Node**.
3. In the Error Workflow, extract the error details and send a formatted notification to a Telegram channel (include node name, error message, and timestamp).

### Option 2: API Retry Logic
**Goal:** Implement a custom retry mechanism.
1. Build a workflow that calls an API.
2. Use the **Wait Node** and an **If Node** to create a loop: if the API call fails, wait 30 seconds and try again.
3. Limit the retries to a maximum of 3 attempts. If it still fails after 3 tries, send an alert.

### Option 3: Two-Step Verification Bot
**Goal:** Use the Wait node for interactive flows.
1. Create a workflow that triggers via a Webhook (e.g., a "Login" attempt).
2. Send a 4-digit code to the user via Telegram.
3. Use the **Wait Node** to wait for the user to reply with the correct code.
4. If the code is correct, return a "Success" response; otherwise, return "Failed".

### Option 4: Master & Sub-workflows
**Goal:** Organize logic using "Execute Workflow".
1. Create a "Dispatcher" (Master) workflow that receives data via a Webhook.
2. Based on the data type (e.g., "Email" or "Telegram"), use the **Execute Workflow Node** to call the appropriate sub-workflow.
3. Create two sub-workflows: one for handling "Email" logic and one for "Telegram" logic.

### Option 5: Request Rate Limiter
**Goal:** Prevent abuse using a database.
1. Create a workflow that triggers via a Webhook.
2. Before processing, check a PostgreSQL table to see how many times the user has triggered the workflow in the last minute.
3. If the count is > 5, return a "Rate limit exceeded" message and stop. Otherwise, update the count and proceed.

## Submission
- Export your workflow(s) as `.json` file(s).
- Save them in this folder as `week-5-solution.json`.
