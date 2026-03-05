# n8n Deployment and Workflow Guide for Students

## Table of Contents

1. [Project Description](#project-description)
2. [Install Podman](#install-podman)
3. [Install Git](#install-git)
4. [Initialize Git Project from Template](#initialize-git-project-from-template)
5. [Install ngrok](#install-ngrok)
6. [Create Telegram Bot](#create-telegram-bot)
7. [Environment Variables](#environment-variables)
8. [Deploy n8n](#deploy-n8n)
9. [Import Workflow Example](#import-workflow-example)
10. [Run Workflow Example](#run-workflow-example)
11. [Container Logs](#container-logs)
12. [Common Issues](#common-issues)
13. [Notes for Students](#notes-for-students)

---

## Project Description

This repository contains materials for a low-code automation course based on **n8n**.

The course focuses on:

- building automation workflows in n8n;
- integrating external APIs;
- running n8n using containers with **Podman**;
- working with databases from workflows;
- implementing production-ready error handling and resilience patterns;
- creating comprehensive technical documentation.

**Course Structure:**

- **Theory** (in `theory/` folder)
- **Project** (for 4-6 weeks): Build a production-ready telecom automation system
- **Mock APIs** for local testing without external dependencies

Ready-made example workflow is stored in the `workflows` directory and can be imported into your own n8n instance for learning and experimentation.

---

## Install Podman

### If you are Windows OS user

1. Install WSL2:

```powershell
wsl --install
wsl --set-default-version 2
```

2. Install Ubuntu 20.04 or 22.04 from Microsoft Store.
3. Install **Podman Desktop**: [https://podman.io/getting-started/installation](https://podman.io/getting-started/installation)
4. Initialize Podman machine:

```powershell
podman machine init
podman machine start
```

5. Install podman-compose inside Ubuntu:

```bash
sudo apt update
sudo apt install -y podman-compose
podman-compose --version
```

---

### If you are Linux OS user

```bash
sudo apt update
sudo apt install -y podman podman-compose
podman --version
podman-compose --version
```

---

> [!WARNING]
> All next commands should be executed inside Ubuntu WSL (if you are Windows OS user).

## Install Git

```bash
sudo apt install -y git
git --version
```

---

## Initialize Git Project from Template

1. Fork [the template repository](https://github.com/raf120196/nc-low-code-n8n-course) to your GitHub account.
2. Clone your fork:

```bash
git clone https://github.com/YOUR_ACCOUNT/nc-low-code-n8n-course.git my-n8n-project
cd my-n8n-project
```

---

## Install ngrok

1. Install ngrok

```bash
curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
| sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update
sudo apt install ngrok
```

2. Sign up at [https://ngrok.com](https://ngrok.com) and copy your auth token.

3. Add your auth token in ngrok configuration:

```bash
ngrok config add-authtoken YOUR_TOKEN_HERE
```

4. Open tmux session for ngrok:

```bash
tmux new -s ngrok
```

5. Expose a local port:

```bash
ngrok http 5678
```

6. Copy forwarding URL. It will be your WEBHOOK_URL.

7. Detach tmux session: click Ctrl+B and then D

## Create Telegram Bot

1. Open @BotFather and create new bot.

2. Copy access token of your bot. It will be your TELEGRAM_BOT_TOKEN.

## Environment Variables

1. Navigate to your project folder:

```bash
cd ~/my-n8n-project
```

2. Copy `.env.example` to `.env` and fill in your actual secrets:

```bash
cp n8n.env.example .env
nano .env
# Fill in N8N_BASIC_AUTH_PASSWORD, DB_POSTGRESDB_PASSWORD, WEBHOOK_URL, TELEGRAM_BOT_TOKEN properties.
```

---

## Deploy n8n

1. Start Podman containers:

```bash
podman-compose up -d
```

2. Make sure containers are running:

```bash
podman-compose ps
```

3. Open PG Adminner [http://localhost:8080](http://localhost:8080/). Check that table `telegram_logs` exists.

4. Open n8n in browser: [http://localhost:5678](http://localhost:5678)

---

## Import Workflow Example

Prepared example workflow is available in the repository in the `workflows` folder.

It demonstrates:

- HTTP triggers;
- API integrations;
- PostgreSQL writes;
- workflow execution logging;
- data processing pipelines.

1. Sing in n8n.

2. Create Telegram API and Postgres credentials based on your TELEGRAM_BOT_TOKEN and PG DB connection settings in .env file.

3. Import `workflow_inline_buttons.json` from `workflows/` folder.

4. Open Telegram and Postgres nodes: n8n will automatically update credentials with your credentials.

---

## Run Workflow Example

1. Publish workflow.

2. Test your Telegram bot: send a message or click inline buttons.

3. Verify logs in PostgreSQL:

```sql
SELECT *
FROM telegram_logs
ORDER BY created_at DESC;
```

---

## Container Logs

```bash
podman logs n8n
```

```bash
podman-compose logs n8n
```

```bash
podman logs postgres
```

---

## Common Issues

**❌ n8n cannot connect to PostgreSQL**

- verify service name is `postgres`
- confirm credentials
- inspect logs

**❌ Workflow does not write data**

- check credentials in n8n
- ensure table exists
- test SQL manually

---

## Notes for Students

- Always run **Git inside WSL/Ubuntu**, not native Windows Git.
- Never commit `.env` with real credentials; use `.env.example` for version control.

---

## Final Project

After completing the course, you'll build a comprehensive final project demonstrating all learned skills.

**Requirements:**
- 20-25 nodes across main workflow and sub-workflows
- 3-4 system integrations (PostgreSQL, Telegram, Google Sheets, Mock APIs)
- Separate error handling workflow
- State machine with 4+ statuses
- Comprehensive documentation and testing

**See:** [`project/README.md`](project/README.md) for complete specifications.

**Available Project Topics:**
1. SIM Card Purchase & Activation System
2. Home Internet/TV Provisioning System

---

## Mock APIs for Testing

Four production-ready OpenAPI mock servers are provided in the `mock-apis/` directory for local testing:

1. **Telecom CRM API** (Port 4010) - Customer management and validation
2. **Billing System API** (Port 4011) - Payments and balance operations  
3. **Network Management API** (Port 4012) - SIM provisioning, outages, roaming, IoT
4. **Geolocation & Enrichment API** (Port 4013) - Geographic data and company information

**Quick Start:**
```bash
# Install Prism
npm install -g @stoplight/prism-cli

# Start a mock server
cd mock-apis
prism mock telecom-crm/openapi.yaml --port 4010

# Or use Docker Compose to start all mocks
docker-compose up
```

**Features:**
- Complete OpenAPI 3.0 specifications
- Sunny day and rainy day scenarios
- Special error triggers for testing
- Interactive Swagger UI documentation
- No authentication required

**See:** [`mock-apis/README.md`](mock-apis/README.md) for detailed documentation.
