# Week 5: Error Handling & Advanced Logic

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
