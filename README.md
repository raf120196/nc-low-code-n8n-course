# n8n Deployment and Workflow Guide for Students

## Table of Contents

1. [Project Description](#project-description)
2. [Install Podman](#install-podman)  
3. [Install Git](#install-git)  
4. [Initialize Git Project from Template](#initialize-git-project-from-template)
5. [Environment Variables](#environment-variables)
6. [Deploy n8n](#deploy-n8n)  
7. [Import Workflow Examples](#import-workflow-examples)
8. [Run Workflows](#run-workflows)
9. [Container Logs](#container-logs)
10. [Common Issues](#common-issues)
11. [Notes for Students](#notes-for-students)

---

## Project Description

This repository contains materials for a low-code automation course based on **n8n**.

The course focuses on:

- building automation workflows in n8n;
- integrating external APIs;
- running n8n using containers with **Podman**;
- working with databases from workflows.

Ready-made example workflows are stored in the `workflows` directory and can be imported into your own n8n instance for learning and experimentation.

---

## Install Podman

### Windows (WSL2)

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

### Linux

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

3. Folder structure:

```
my-n8n-project/
├─ README.md                  # This guide
├─ .gitignore                 # Ignore .env and logs
├─ workflows/                 # Example workflows
├─ exercises/                 # Student exercises
├─ final_project/             # Final project folder
├─ n8n.env.example            # Template .env with dummy placeholders
├─ docker-compose.yml         # Docker compose file
```

---

## Environment Variables

1. Navigate to your project folder:

```bash
cd ~/my-n8n-project
```

2. Copy `.env.example` to `.env` and fill in your actual secrets:

```bash
cp n8n.env.example .env
nano .env
# Fill in N8N_BASIC_AUTH_PASSWORD, TELEGRAM_BOT_TOKEN, DB_POSTGRESDB_PASSWORD
```

3. Install ngrok:

```bash
curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
| sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update
sudo apt install ngrok
```

4. Sign up at [https://ngrok.com](https://ngrok.com) and copy your auth token.

5. Then run:

```bash
ngrok config add-authtoken YOUR_TOKEN_HERE
```

6. Expose a local port:

```bash
ngrok http 5678
```

7. Update WEBHOOK_URL in .env

---

## Deploy n8n

1. Start Podman containers:

```bash
podman-compose up -d
podman-compose logs -f n8n
```

2. Open n8n in browser: [http://localhost:5678](http://localhost:5678)

---

## Import Workflow Examples

Prepared workflows are available in the repository in the `workflows` folder.

They demonstrate:

- HTTP triggers;
- API integrations;
- PostgreSQL writes;
- workflow execution logging;
- data processing pipelines.

1. Open n8n → Workflows → Import from JSON.  
2. Import the files from `workflows/`:

- `workflow_echo_pg.json` → logs Telegram messages to PostgreSQL and replies.  
- `workflow_inline_buttons.json` → sends inline buttons and logs clicks.  

---

### PostgreSQL Setup (Database Schema)

Some example workflows log execution data into PostgreSQL.  
For this purpose, create the following table:

```sql
CREATE TABLE telegram_logs (
    id SERIAL PRIMARY KEY,
    chat_id TEXT NOT NULL,
    user_name TEXT NOT NULL,
    message_text JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Table Description

| Column | Purpose |
|------|--------|
| id | Unique identifier |
| chat_id | Unique identifier of the chat |
| user_name | Name of user |
| message_text | Message |
| created_at | Record creation time |

---

## Run Workflows

1. Make sure containers are running:

```bash
podman-compose ps
```

2. Open the workflow in n8n, toggle **Active**.  
3. Test your Telegram bot: send a message or click inline buttons.  
4. Verify logs in PostgreSQL (table `telegram_logs`):

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
- Work on exercises in the `exercises/` folder and final project in `final_project/`. 
