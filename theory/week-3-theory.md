# Week 3: External APIs & Messaging

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
