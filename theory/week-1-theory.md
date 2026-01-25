# Week 1: Low-Code Fundamentals & Environment Setup

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
- [n8n Course: Level 1 (Beginner)](https://academy.n8n.io/courses/n8n-beginner-course)
- [Podman Desktop Documentation](https://podman-desktop.io/docs/intro)
