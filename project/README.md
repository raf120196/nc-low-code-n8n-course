# Final Project Specifications

## Overview

It is necessary to design, implement, and document a **production-ready automated system** using n8n and multiple integrations, specifically tailored for the **Telecommunications Industry**.

This project requires you to demonstrate all learned skills: workflow design, data manipulation, external API integration, error handling, database operations, and comprehensive documentation.

**Timeline:** 4-6 weeks

---

## Core Requirements

### 1. Workflow Complexity

**Minimum 20-25 nodes total** across all workflows:
- **Main workflow:** 15-18 nodes
- **Sub-workflow(s):** 1-2 separate workflows (5-10 nodes each)
- **Error handler workflow:** 3-5 nodes

**Required node types:**
- Logic nodes: Switch, IF, Filter (minimum 2)
- Data transformation: Set/Edit Fields, Code Node (minimum 1 Code Node)
- Integration nodes: PostgreSQL, HTTP Request, Telegram/Email
- Error handling: Error Trigger in separate workflow

### 2. System Integrations

**Minimum 3-4 integrations** (all work locally):

1. **PostgreSQL** - Primary database for persistent data
2. **Telegram** - User interaction and notifications
3. **Google Sheets** - Reporting, configuration, or temporary storage
4. **Mock API** - External system integration (see Mock API section below)

### 3. State Machine Logic

Implement a **status-based workflow** with minimum 4 states stored in PostgreSQL:

```
pending → processing → completed → failed
```

Or alternative statuses appropriate for your project (e.g., `submitted → approved → activated → closed`).

**Requirements:**
- Status updates must be logged in database
- Transitions must follow business logic rules
- Each state should trigger different actions

### 4. Error Handling & Resilience

**Mandatory error handling components:**

1. **Separate Error Workflow**
   - Uses Error Trigger Node
   - Captures: workflow name, node name, error message, timestamp
   - Sends detailed notifications via Telegram
   - Logs errors to PostgreSQL `error_logs` table

2. **Node-Level Retry**
   - Enable retry on all critical HTTP Request nodes
   - Configure: 3 attempts, exponential backoff
   - Document which nodes have retry enabled

3. **Graceful Degradation**
   - Use "Continue on Fail" for non-critical operations
   - Implement fallback logic when external services unavailable
   - Document degradation scenarios

### 5. Data Operations

**Required data operations:**

1. **Data Enrichment** from 2-3 sources
   - Example: Start with user input → enrich from Mock API → add data from PostgreSQL

2. **Batch Processing**
   - Handle lists of 10-20 items
   - Use Loop or Split In Batches node

3. **Data Transformation**
   - Complex transformations in Code Node
   - Format conversions (JSON ↔ structured data)
   - Calculations and aggregations

4. **Structured Logging**
   - Log all workflow executions to PostgreSQL
   - Include: `workflow_name`, `execution_id`, `status`, `duration_ms`, `error_message`, `timestamp`

### 6. Security Requirements

**Mandatory security practices:**

1. **Input Validation**
   - Validate all user inputs (required fields, data types, formats)
   - Use IF nodes or Code Node for validation
   - Return clear error messages for invalid data

2. **Secrets Management**
   - ALL credentials via environment variables (n8n.env)
   - NO hardcoded API keys, passwords, or tokens
   - Document all required environment variables

3. **Rate Limiting** (simple implementation)
   - Track request count in PostgreSQL
   - Limit: 10 requests per user per minute
   - Return 429 error when exceeded

### 7. Documentation Requirements

Your project must include:

#### A. Technical README (3-5 pages)

**Structure:**

1. **Problem Statement** (2-3 paragraphs)
   - What business problem does this solve?
   - Who are the users?
   - What value does it provide?

2. **Architecture Overview**
   - Mermaid flowchart of main workflow
   - Description of key components
   - Integration points diagram

3. **Workflow Diagram**
   - High-quality screenshot from n8n
   - Use Sticky Notes to annotate sections
   - Clearly label: inputs, processing, outputs

4. **Database Schema**
   - List all tables with fields and types
   - Describe relationships
   - Include provided SQL schema file

5. **Setup Instructions**
   - Step-by-step installation guide
   - How to configure credentials
   - List of environment variables
   - How to run Mock API servers

6. **Testing Guide**
   - How to test each scenario
   - Sample test data
   - Expected outcomes

7. **Known Limitations**
   - What's simplified or not implemented
   - Future improvements

#### B. Test Scenarios Document (1-2 pages)

Include in `tests/test-scenarios.md`:

1. **Happy Path Tests** (2-3 scenarios)
   - Normal successful execution
   - Expected inputs and outputs
   - Screenshots of execution results

2. **Edge Cases** (3-4 scenarios)
   - Empty/missing fields
   - Invalid data formats
   - Boundary values

3. **Error Scenarios** (2-3 types)
   - Mock API returns 500 error
   - Database unavailable
   - Invalid user input
   - Document how system handles each

4. **Results Documentation**
   - Screenshots from n8n Executions tab
   - Database records after test
   - Telegram notification examples

#### C. Database Schema Files

Include in `database/` folder:

1. **schema.sql** - CREATE TABLE statements for all tables
2. **seed-data.sql** - INSERT statements with test data

---

## Mock API System

All external integrations should use **local Mock APIs** for testing. This ensures complete control over test scenarios without external dependencies.

### Available Mock APIs

Four OpenAPI-compliant mock servers are provided in the `mock-apis/` folder:

1. **Telecom CRM API** (`localhost:4010`)
   - Customer profiles
   - Credit score checks
   - Blacklist verification

2. **Billing System API** (`localhost:4011`)
   - Account management
   - Payment processing
   - Balance operations

3. **Network Management API** (`localhost:4012`)
   - SIM provisioning
   - Network outage data
   - Roaming activation
   - IoT telemetry

4. **Geolocation & Enrichment API** (`localhost:4013`)
   - Geographic data lookup
   - Region information
   - Company data enrichment

### Starting Mock APIs

```bash
# Install Prism (one time)
npm install -g @stoplight/prism-cli

# Start individual mock server
prism mock mock-apis/telecom-crm/openapi.yaml --port 4010

# Or start all mocks with Docker Compose
cd mock-apis
docker-compose up
```

### Accessing Swagger UI

After starting a mock server, open:
- `http://localhost:4010` (Telecom CRM)
- `http://localhost:4011` (Billing)
- `http://localhost:4012` (Network Management)
- `http://localhost:4013` (Geolocation)

Browse endpoints, view request/response schemas, and try examples.

### Testing Rainy Day Scenarios

Mock APIs support special trigger values to simulate errors:

**Trigger 500 Error:**
```
customer_id=error500  → Returns 500 Internal Server Error
```

**Trigger 404 Error:**
```
customer_id=error404  → Returns 404 Not Found
```

**Trigger Timeout:**
```
customer_id=timeout  → Delays response 30 seconds
```

**Trigger Validation Error:**
```
amount=99999  → Returns 400 Bad Request (exceeds limit)
```

See each API's OpenAPI spec for complete list of error triggers.

---

## Project Topics

Choose ONE topic below or propose your own (requires instructor approval).

---

### Topic 1: SIM Card Purchase & Activation System

**Business Context:**  
Automate the complete lifecycle of SIM card orders from customer request through activation, including fraud detection, approval workflow, and multi-system provisioning.

**Complexity Level:** ⭐⭐⭐ (Medium-High)

#### Data Intake Fields

| Field | Type | Validation | Example |
|:---|:---|:---|:---|
| `customer_name` | String | Required, 2-100 chars | "John Doe" |
| `customer_email` | String | Required, valid email | "john.doe@example.com" |
| `id_number` | String | Required, alphanumeric | "AB123456" |
| `sim_type` | String | Required, enum: ["physical", "eSIM"] | "eSIM" |
| `plan_name` | String | Required | "Unlimited Ultra 5G" |

#### Workflow Steps

**1. Input & Validation (3-4 nodes)**
- Trigger: n8n Form or Webhook
- Validate all required fields
- Check email format and ID number pattern
- Return 400 error if validation fails

**2. Fraud Detection (4-5 nodes)**
- Query PostgreSQL for daily order count by ID number
- HTTP Request to Telecom CRM API: `GET /api/v1/customers/{id_number}/blacklist-status`
- HTTP Request to Telecom CRM API: `GET /api/v1/customers/{id_number}/credit-score`
- IF node: Block if blacklisted OR credit_score < 500 OR daily_orders > 3
- Insert order record in PostgreSQL with status: `pending_approval`

**3. Approval Workflow (3-4 nodes)** *(Optional: Can use Sub-workflow)*
- If fraud_score > 70: Send approval request to manager via Telegram with inline buttons
- Wait for Webhook (approval response)
- Update status to `approved` or `rejected`
- Log decision in audit_trail table

**4. Multi-Stage Provisioning (5-6 nodes)**
- HTTP Request to Network Management API: `POST /api/v1/sim/provision`
  - Receives: `phone_number`, `iccid`
- HTTP Request to Billing System API: `POST /api/v1/accounts`
  - Creates billing account
- HTTP Request to Billing System API: `POST /api/v1/accounts/{id}/charge`
  - Initial activation fee
- Update PostgreSQL status to `activated`

**5. Notification (2-3 nodes)** *(Can be Sub-workflow)*
- Send confirmation via Telegram with SIM details
- Log successful activation with timestamp

**6. Error Handling**
- Separate Error Workflow catches all failures
- Updates order status to `failed`
- Sends alert to support team
- Logs detailed error information

#### Required Mock API Endpoints

- `GET /api/v1/customers/{customer_id}/credit-score`
- `GET /api/v1/customers/{customer_id}/blacklist-status`
- `POST /api/v1/sim/provision`
- `POST /api/v1/accounts`
- `POST /api/v1/accounts/{account_id}/charge`

#### Database Schema

```sql
CREATE TABLE sim_orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(255),
    id_number VARCHAR(50),
    sim_type VARCHAR(20),
    plan_name VARCHAR(100),
    phone_number VARCHAR(20),
    status VARCHAR(50), -- pending_approval, approved, activated, failed
    fraud_score INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE audit_trail (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES sim_orders(id),
    action VARCHAR(100),
    performed_by VARCHAR(100),
    details JSONB,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### State Machine

```
pending_approval → approved → provisioning → activated
                              ↓
                            failed
```

#### Success Criteria

- [ ] Complete fraud detection with 3 checks
- [ ] Two-step approval process (auto-check + manual)
- [ ] Sequential API calls to 3 different mock endpoints
- [ ] Status updates at each stage
- [ ] Error workflow with rollback capability
- [ ] Audit logging for compliance
- [ ] 20+ nodes including sub-workflows

---

### Topic 2: Home Internet/TV Provisioning System

**Business Context:**  
Manage technical setup and scheduling for fiber internet and TV services, including coverage validation, equipment assignment, technician dispatch, and customer communication.

**Complexity Level:** ⭐⭐⭐ (Medium-High)

#### Data Intake Fields

| Field | Type | Validation | Example |
|:---|:---|:---|:---|
| `customer_name` | String | Required | "Alice Smith" |
| `customer_phone` | String | Required, format check | "+1234567890" |
| `address` | String | Required | "123 Fiber St, Tech City" |
| `zip_code` | String | Required, 5 digits | "10111" |
| `service_type` | String | Enum: ["internet", "tv", "bundle"] | "bundle" |

#### Workflow Steps

**1. Geographic Validation (4-5 nodes)**
- Trigger: n8n Form or Webhook
- Validate input fields
- HTTP Request to Geolocation API: `GET /api/v1/geo/lookup?zip={zip_code}`
  - Returns: `nearest_hub_id`, `infrastructure_type` (Fiber/Copper), `coverage_available`
- Query Google Sheets for coverage matrix by zip_code
- IF node: Stop if no coverage, suggest waitlist

**2. Account & Equipment Setup (4-5 nodes)**
- Insert service_order in PostgreSQL with status: `pending_equipment`
- Code Node: Determine required equipment based on service_type
  - internet → Router + ONT
  - tv → Set-top box
  - bundle → All equipment
- Check equipment inventory in Google Sheets
- Reserve equipment, update inventory
- Update status to `equipment_assigned`

**3. Installation Scheduling (3-4 nodes)** *(Can be Sub-workflow)*
- Code Node: Calculate installation date
  - Current date + lead time (from Google Sheets config)
  - Skip weekends
  - Check technician availability
- HTTP Request to mock scheduling API
- Send installation details to warehouse via Telegram
- Update PostgreSQL with `installation_date`

**4. Provisioning Sequence (5-6 nodes)**
- HTTP Request to Network Management API: `POST /api/v1/network/line-test`
  - Tests physical connection
- HTTP Request: `POST /api/v1/network/ont-activate`
  - Activates optical terminal
- HTTP Request: `POST /api/v1/network/service-bind`
  - Links account to network hub
- Update status to `provisioned`

**5. Customer Communication (2-3 nodes)**
- Send installation confirmation via Telegram
- Include: date, time window, equipment list, technician contact
- Log communication in PostgreSQL

**6. Quality Monitoring** *(Optional advanced feature)*
- Schedule Trigger: Check service quality 24h after installation
- If issues detected, create support ticket

#### Required Mock API Endpoints

- `GET /api/v1/geo/lookup`
- `POST /api/v1/network/line-test`
- `POST /api/v1/network/ont-activate`
- `POST /api/v1/network/service-bind`

#### Database Schema

```sql
CREATE TABLE service_orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_phone VARCHAR(20),
    address TEXT,
    zip_code VARCHAR(10),
    service_type VARCHAR(50),
    infrastructure_type VARCHAR(20),
    nearest_hub_id VARCHAR(50),
    equipment_list JSONB,
    installation_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### State Machine

```
pending_equipment → equipment_assigned → scheduled → provisioned → active
                                                     ↓
                                                   failed
```

#### Success Criteria

- [ ] Cross-reference data between PostgreSQL and Google Sheets
- [ ] Dynamic equipment assignment logic
- [ ] Date calculation with business rules
- [ ] Multi-stage provisioning with API calls
- [ ] Separate notification sub-workflow
- [ ] Error handling for each provisioning step
- [ ] 20+ nodes total

---

## Evaluation Rubric

Your project will be assessed on the following criteria:

### 1. Functionality (35 points)

- **Core Features Complete** (15 pts)
  - All required workflow steps implemented
  - Correct logic flow
  - Data processed accurately

- **Integration Quality** (10 pts)
  - All 3-4 integrations working
  - Correct API usage
  - Proper data exchange

- **State Machine** (10 pts)
  - Minimum 4 states implemented
  - Correct status transitions
  - Status logged in database

### 2. Error Handling & Resilience (25 points)

- **Error Workflow** (10 pts)
  - Separate workflow with Error Trigger
  - Captures all failure details
  - Sends notifications

- **Node-Level Retry** (8 pts)
  - Configured on critical nodes
  - Proper retry settings
  - Handles transient failures

- **Rainy Day Testing** (7 pts)
  - Tested with Mock API error triggers
  - System handles failures gracefully
  - Evidence in test scenarios document

### 3. Architecture & Code Quality (20 points)

- **Sub-Workflows** (8 pts)
  - 1-2 separate workflows for modularity
  - Clear separation of concerns
  - Reusable components

- **Code Quality** (7 pts)
  - Clear node naming
  - Sticky Notes for documentation
  - Clean Code Node implementation
  - No hardcoded values

- **Database Design** (5 pts)
  - Appropriate schema
  - Proper data types
  - Indexed fields where needed

### 4. Documentation & Testing (15 points)

- **README Quality** (8 pts)
  - Clear problem statement
  - Architecture diagram
  - Complete setup instructions
  - Testing guide

- **Test Scenarios** (7 pts)
  - Happy path documented
  - Edge cases covered
  - Error scenarios tested
  - Results with evidence

### 5. Code Craftsmanship (5 points)

- Attention to detail
- Professional presentation
- Goes beyond minimum requirements
- Innovative solutions

**Total: 100 points**

**Passing grade: 70 points**

---

## Project Structure Template

Organize your project files as follows:

```
final_project_<your_topic>/
├── workflows/
│   ├── main-workflow.json          # Export from n8n
│   ├── sub-workflow-*.json         # Any sub-workflows
│   └── error-handler.json          # Error workflow
├── database/
│   ├── schema.sql                  # CREATE TABLE statements
│   └── seed-data.sql               # Test data INSERT statements
├── tests/
│   ├── test-scenarios.md           # Detailed test documentation
│   ├── test-data.json              # Sample input data
│   └── results/                    # Screenshots of test results
│       ├── happy-path-1.png
│       ├── error-scenario-1.png
│       └── ...
├── docs/
│   ├── workflow-diagram.png        # Screenshot from n8n
│   └── architecture.md             # Mermaid diagrams (optional)
└── README.md                       # Main documentation
```

---

## Tips for Success

### 1. Start Small, Iterate

- Build the happy path first
- Add error handling second
- Enhance with sub-workflows last

### 2. Test Continuously

- Test each node as you build
- Use Mock API error triggers frequently
- Document issues and solutions

### 3. Document as You Go

- Add Sticky Notes in n8n immediately
- Take screenshots after each milestone
- Write README sections incrementally

### 4. Use Mock APIs Effectively

- Start mock servers before developing
- Keep Swagger UI open for reference
- Test all error scenarios

### 5. Database First

- Design schema before starting workflow
- Create tables early
- Test SQL queries independently

### 6. Version Control

- Commit workflow JSON after each major change
- Use meaningful commit messages
- Create backups regularly

### 7. Ask for Help

- Join office hours for technical issues
- Share challenges in discussion forum
- Review example workflows

---

## Submission Instructions

Submit your complete project by **[Deadline Date]**:

1. **Export Workflows**
   - In n8n: Settings → Export
   - Save as JSON files

2. **Package Everything**
   - Create ZIP archive named: `final_project_<your_name>_<topic>.zip`
   - Include all files from project structure template

3. **Upload**
   - Submit to course platform
   - Include a brief summary (3-4 sentences) about your project

4. **Optional: Demo Video**
   - 5-10 minute walkthrough
   - Show workflow execution
   - Explain key design decisions

---

## Additional Resources

### Mock API Setup

See `mock-apis/README.md` for detailed instructions on:
- Installing Prism
- Starting mock servers
- Using Docker Compose
- Accessing Swagger UI
- Error trigger reference

### Code Snippets

Common Code Node examples for:
- Data validation
- Date calculations
- Array transformations
- Complex filtering

See course repository: `resources/code-snippets/`

### SQL Templates

Pre-built queries for common operations:
- Bulk inserts
- Aggregations
- Time-based queries
- Audit logging

See course repository: `resources/sql-templates/`

---

## Frequently Asked Questions

**Q: What if I want to add more features than required?**  
A: Excellent! Extra features can earn you points in the "Craftsmanship" category. Document them clearly in your README.

**Q: Can I work with a partner?**  
A: The final project is individual. However, you can discuss concepts and help debug issues with classmates.

**Q: What if the Mock API doesn't have an endpoint I need?**  
A: You can propose an additional endpoint by submitting an OpenAPI spec addition. Or work around it using existing endpoints creatively.

**Q: How do I handle authentication with Mock APIs?**  
A: Mock APIs don't require authentication. In your documentation, note where authentication would be added in a production system.

---

## Academic Integrity

- You must write your own workflows and code
- You may reference course materials and documentation
- You may get help debugging, but not complete solutions
- Plagiarism will result in a zero grade
- Include citations if you use external code snippets
