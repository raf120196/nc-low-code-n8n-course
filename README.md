# n8n Deployment and Workflow Guide for Students

This guide explains how to deploy **n8n** locally using **Podman**, manage your project with **Git**, and run **Telegram Bot workflow examples** safely. Instructions cover **Windows (WSL2)** and **Linux** users.

---

## Table of Contents

1. [Install Podman](#install-podman)  
2. [Install Git](#install-git)  
3. [Initialize Git Project from Template](#initialize-git-project-from-template)  
4. [Deploy n8n](#deploy-n8n)  
5. [Launching Workflow Examples](#launching-workflow-examples)  
   - [Prepare `.env` File](#prepare-env-file)  
   - [Import Workflow Examples](#import-workflow-examples)  
   - [Run Workflows](#run-workflows)  

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
```

---

## Deploy n8n

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

3. Start Podman containers:

```bash
podman-compose up -d
podman-compose logs -f n8n
```

4. Open n8n in browser: [http://localhost:5678](http://localhost:5678)

5. Install ngrok:

```bash
curl -fsSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null
echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
| sudo tee /etc/apt/sources.list.d/ngrok.list
sudo apt update
sudo apt install ngrok
```

6. Sign up at [https://ngrok.com](https://ngrok.com) and copy your auth token.

7. Then run:

```bash
ngrok config add-authtoken YOUR_TOKEN_HERE
```

8. Expose a local port:

```bash
ngrok http 5678
```

9. Update WEBHOOK_URL in .env and restart Podman containers:

```bash
podman-compose down
podman-compose up -d
```

---

## Launching Workflow Examples

### Prepare `.env` File

1. Copy template:

```bash
cp n8n.env.example .env
```

2. Fill in real secrets (n8n auth, PostgreSQL, Telegram bot token).  
3. Start containers:

```bash
podman-compose up -d
```

---

### Import Workflow Examples

1. Open n8n → Workflows → Import from JSON.  
2. Import the files from `workflows/`:

- `workflow_echo_pg.json` → logs Telegram messages to PostgreSQL and replies.  
- `workflow_inline_buttons.json` → sends inline buttons and logs clicks.  

---

### Run Workflows

1. Make sure containers are running:

```bash
podman-compose ps
```

2. Open the workflow in n8n, toggle **Active**.  
3. Test your Telegram bot: send a message or click inline buttons.  
4. Verify logs in PostgreSQL (table `telegram_logs`):

```sql
SELECT * FROM telegram_logs;
```

---

## Notes for Students

- Always run **Git inside WSL/Ubuntu**, not native Windows Git.  
- Never commit `.env` with real credentials; use `.env.example` for version control.  
- Work on exercises in the `exercises/` folder and final project in `final_project/`. 
