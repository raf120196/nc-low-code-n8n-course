# Mock APIs for n8n Final Project

This directory contains OpenAPI 3.0 specifications for four mock APIs that simulate real telecom backend systems. These APIs allow students to test their n8n workflows locally without depending on external services or paid API keys.

## Overview

**Four Mock API Servers:**

1. **Telecom CRM API** (Port 4010)
   - Customer profile management
   - Credit score validation
   - Blacklist verification

2. **Billing System API** (Port 4011)
   - Account management
   - Payment processing
   - Balance operations

3. **Network Management API** (Port 4012)
   - SIM provisioning
   - Network outage monitoring
   - Roaming activation
   - IoT device telemetry

4. **Geolocation & Enrichment API** (Port 4013)
   - Geographic data lookup
   - Region information
   - Company data enrichment
   - Roaming partner information

---

## Prerequisites

You need **one** of the following tools installed:

### Option 1: Prism (Recommended)

Prism is a lightweight mock server that reads OpenAPI specs.

**Install via npm:**
```bash
npm install -g @stoplight/prism-cli
```

**Verify installation:**
```bash
prism --version
```

### Option 2: Docker + Docker Compose

If you prefer containerized approach, ensure Docker is installed and running.

**Verify:**
```bash
docker --version
docker-compose --version
```

---

## Quick Start

### Method 1: Start Individual Mock with Prism

Navigate to the mock-apis directory:
```bash
cd mock-apis
```

**Start Telecom CRM API:**
```bash
prism mock telecom-crm/openapi.yaml --port 4010
```

**Start Billing System API:**
```bash
prism mock billing-system/openapi.yaml --port 4011
```

**Start Network Management API:**
```bash
prism mock network-management/openapi.yaml --port 4012
```

**Start Geolocation API:**
```bash
prism mock geolocation/openapi.yaml --port 4013
```

**Note:** Each command should be run in a separate terminal window/tab.

### Method 2: Start All Mocks with Docker Compose

From the mock-apis directory:

```bash
docker-compose up
```

This starts all four mock servers simultaneously.

To run in background (detached mode):
```bash
docker-compose up -d
```

To stop all mocks:
```bash
docker-compose down
```

---

## Accessing Mock APIs

Once a mock server is running, you can access it:

### Base URLs

- Telecom CRM: `http://localhost:4010`
- Billing System: `http://localhost:4011`
- Network Management: `http://localhost:4012`
- Geolocation: `http://localhost:4013`

### Swagger UI

Prism provides an interactive API documentation interface. After starting a mock:

**Open in browser:**
- http://localhost:4010 (Telecom CRM)
- http://localhost:4011 (Billing)
- http://localhost:4012 (Network Management)
- http://localhost:4013 (Geolocation)

You'll see:
- List of all endpoints
- Request/response schemas
- Example requests
- Try-it-out functionality

---

## Testing Error Scenarios

Mock APIs support **special trigger values** to simulate different error conditions.

### Common Error Triggers

#### Telecom CRM API

**404 Not Found:**
```bash
GET http://localhost:4010/api/v1/customers/error404
```

**500 Internal Server Error:**
```bash
GET http://localhost:4010/api/v1/customers/error500
```

**Timeout (30 second delay):**
```bash
GET http://localhost:4010/api/v1/customers/timeout
```

**Low Credit Score:**
```bash
GET http://localhost:4010/api/v1/customers/AB000/credit-score
```
Returns credit_score < 500

**Blacklisted Customer:**
```bash
GET http://localhost:4010/api/v1/customers/BLOCKED123/blacklist-status
```
Returns is_blacklisted: true

#### Billing System API

**Insufficient Funds:**
```bash
GET http://localhost:4011/api/v1/accounts/insufficient/balance
```
Returns very low balance

**Amount Exceeds Limit:**
```bash
POST http://localhost:4011/api/v1/accounts/ACC-001/charge
Body: {"amount": 15000, "description": "Test"}
```
Returns 400 Bad Request (exceeds 10,000 limit)

**Invalid Payment Method:**
```bash
POST http://localhost:4011/api/v1/payments
Body: {"account_id": "ACC-001", "amount": 50, "payment_method": "invalid"}
```
Returns 400 Bad Request

#### Network Management API

**Invalid SIM Type:**
```bash
POST http://localhost:4012/api/v1/sim/provision
Body: {"customer_id": "AB123", "sim_type": "unknown", "plan_id": "PLAN-01"}
```
Returns 400 Bad Request

**Region Under Maintenance:**
```bash
GET http://localhost:4012/api/v1/region/maintenance/info
```
Returns 503 Service Unavailable

**Device Error:**
```bash
GET http://localhost:4012/api/v1/devices/error500/telemetry
```
Returns 500 Internal Server Error

#### Geolocation API

**Region Not Found:**
```bash
GET http://localhost:4013/api/v1/region/error404/info
```
Returns 404 Not Found

**Unsupported Country:**
```bash
GET http://localhost:4013/api/v1/roaming/partners?country=XX
```
Returns 404 Not Found

---

## Using Mock APIs in n8n

### Step 1: Start Mock Servers

Start all required mock servers before opening n8n.

### Step 2: Configure HTTP Request Nodes

In your n8n workflow, use HTTP Request nodes:

**Example: Get Customer Profile**

1. Add HTTP Request node
2. Configure:
   - Method: `GET`
   - URL: `http://localhost:4010/api/v1/customers/{{$json.customer_id}}`
3. No authentication needed (mocks don't require auth)

**Example: Create Billing Account**

1. Add HTTP Request node
2. Configure:
   - Method: `POST`
   - URL: `http://localhost:4011/api/v1/accounts`
   - Body:
     ```json
     {
       "customer_id": "{{$json.customer_id}}",
       "account_type": "prepaid",
       "currency": "USD",
       "initial_balance": 50.00
     }
     ```

### Step 3: Enable Retry for Resilience

For all HTTP Request nodes calling mock APIs:

1. Click on node settings
2. Go to "Retry On Fail" tab
3. Enable retry
4. Set:
   - Max Tries: 3
   - Wait Between Tries: 2000ms (2 seconds)

### Step 4: Test Error Scenarios

To test your error handling:

1. Use special trigger values (e.g., `customer_id=error500`)
2. Verify your Error Workflow catches failures
3. Check error logging in PostgreSQL
4. Verify Telegram notifications are sent

---

## Example Test Scenarios

### Scenario 1: Happy Path - SIM Provisioning

```bash
# 1. Check customer blacklist
GET http://localhost:4010/api/v1/customers/AB123456/blacklist-status
# Response: {"is_blacklisted": false}

# 2. Check credit score
GET http://localhost:4010/api/v1/customers/AB123456/credit-score
# Response: {"credit_score": 720}

# 3. Provision SIM
POST http://localhost:4012/api/v1/sim/provision
Body: {
  "customer_id": "AB123456",
  "sim_type": "eSIM",
  "plan_id": "PLAN-UNLIMITED-5G"
}
# Response: 201 Created with phone_number

# 4. Create billing account
POST http://localhost:4011/api/v1/accounts
Body: {
  "customer_id": "AB123456",
  "account_type": "postpaid",
  "currency": "USD",
  "credit_limit": 200
}
# Response: 201 Created with account_id
```

### Scenario 2: Error Path - Blacklisted Customer

```bash
# 1. Check blacklist
GET http://localhost:4010/api/v1/customers/BLOCKED123/blacklist-status
# Response: {"is_blacklisted": true, "reason": "Multiple payment failures"}

# Workflow should stop here and send alert
```

### Scenario 3: Error Path - Insufficient Funds

```bash
# 1. Check balance
GET http://localhost:4011/api/v1/accounts/insufficient/balance
# Response: {"current_balance": 2.50}

# 2. Try to charge
POST http://localhost:4011/api/v1/accounts/insufficient/charge
Body: {"amount": 25.00, "description": "Monthly fee"}
# Response: 402 Payment Required

# Workflow should handle insufficient funds error
```

---

## Troubleshooting

### Mock server won't start

**Error:** "Port already in use"

**Solution:** Another process is using the port.

```bash
# Find process using port 4010 (example)
# Windows PowerShell:
Get-Process -Id (Get-NetTCPConnection -LocalPort 4010).OwningProcess

# Linux/Mac:
lsof -i :4010

# Kill the process or use a different port:
prism mock telecom-crm/openapi.yaml --port 4020
```

### Can't access Swagger UI

**Issue:** Browser shows "Cannot connect"

**Solutions:**
1. Verify mock server is running (check terminal output)
2. Confirm correct port number
3. Try `http://127.0.0.1:4010` instead of `localhost`
4. Check firewall settings

### n8n can't reach mock API

**Issue:** HTTP Request node returns connection error

**Solutions:**
1. Ensure mock server is running
2. Use `http://localhost:4010` not `https://`
3. If n8n is in Docker, use `http://host.docker.internal:4010`
4. Check n8n can reach localhost:
   ```bash
   # From n8n container
   curl http://localhost:4010/api/v1/customers/test
   ```

### Prism returns unexpected responses

**Issue:** Getting wrong data or errors

**Check:**
1. Request URL matches OpenAPI spec exactly
2. HTTP method is correct (GET, POST, etc.)
3. Request body matches schema (for POST/PUT)
4. Review OpenAPI spec for required fields

---

## Advanced: Customizing Mock Responses

If you need custom mock behavior beyond what Prism provides, you can:

### Option 1: Modify OpenAPI Spec

Edit the YAML file and add more examples:

```yaml
responses:
  '200':
    content:
      application/json:
        examples:
          my_custom_example:
            summary: Custom scenario
            value:
              customer_id: 'CUSTOM-001'
              name: 'Custom Name'
```

Restart Prism to load changes.

### Option 2: Use Mockoon (GUI Alternative)

1. Download Mockoon: https://mockoon.com/
2. Import OpenAPI spec
3. Customize responses visually
4. Add dynamic behaviors

### Option 3: Create Custom Mock Server

For advanced scenarios, create a simple Express.js server:

```javascript
const express = require('express');
const app = express();

app.get('/api/v1/customers/:id', (req, res) => {
  // Custom logic here
  if (req.params.id === 'special-case') {
    return res.json({custom: 'response'});
  }
  
  // Default response
  res.json({customer_id: req.params.id, name: 'Default'});
});

app.listen(4010);
```

---

## OpenAPI Specifications

Each API has a detailed OpenAPI spec in its subdirectory:

- `telecom-crm/openapi.yaml` - Customer and validation APIs
- `billing-system/openapi.yaml` - Billing and payment APIs
- `network-management/openapi.yaml` - Network operations APIs
- `geolocation/openapi.yaml` - Geographic and enrichment APIs

These specs include:
- Complete endpoint documentation
- Request/response schemas with types
- Multiple examples for each endpoint
- Error response definitions
- Special trigger documentation

You can view these specs:
- In any text editor (they're YAML)
- In Swagger UI (when Prism is running)
- Online: https://editor.swagger.io/ (paste contents)

---

## Docker Compose Configuration

The provided `docker-compose.yml` runs all four mocks using Stoplight Prism containers.

**Start all mocks:**
```bash
docker-compose up
```

**Start specific mock:**
```bash
docker-compose up telecom-crm
```

**View logs:**
```bash
docker-compose logs -f
```

**Restart a mock:**
```bash
docker-compose restart billing-system
```

---

## Tips for Students

### 1. Keep Mocks Running

Start all mocks at the beginning of your work session and leave them running. They use minimal resources.

### 2. Use Swagger UI for Reference

Keep Swagger UI tabs open while building workflows. Quickly reference request formats and expected responses.

### 3. Test Error Cases Early

Don't wait until the end to test error scenarios. Build error handling as you go.

### 4. Log All API Calls

In n8n, log every mock API request/response to PostgreSQL. This helps with debugging.

### 5. Create Test Data Collections

Prepare sets of test data (customer IDs, amounts, etc.) for different scenarios:
- happy_path_data.json
- error_scenarios_data.json
- edge_cases_data.json

### 6. Document Which Mock Endpoints You Use

In your project README, list all mock API endpoints your workflow calls. This helps reviewers understand your integration points.

---

## Support

**Mock API Issues:**
- Check this README first
- Review the OpenAPI spec for the specific API
- Test endpoint directly with curl or Postman
- Check Prism logs for errors

**n8n Integration Issues:**
- Verify mock is responding (curl test)
- Check n8n HTTP Request node configuration
- Review n8n execution logs
- Test with fixed values before using expressions

---

## Additional Resources

- **Prism Documentation:** https://docs.stoplight.io/docs/prism/
- **OpenAPI Specification:** https://swagger.io/specification/
- **Mockoon Documentation:** https://mockoon.com/docs/latest/about/
- **n8n HTTP Request Node:** https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.httprequest/

---

## FAQ

**Q: Do I need internet connection to use mock APIs?**  
A: No, they run completely locally.

**Q: Can I modify the mock responses?**  
A: Yes, edit the OpenAPI YAML files and restart Prism.

**Q: Will mocks remember data between requests?**  
A: No, Prism is stateless. Each request is independent. Use PostgreSQL for persistence.

**Q: Can I use mock APIs in my final submission?**  
A: Yes, mocks are designed for testing and demonstrations.

**Q: What if I need an endpoint that doesn't exist?**  
A: You can add it to the OpenAPI spec or work around it creatively with existing endpoints.

**Q: Do mocks enforce validation rules?**  
A: Prism validates against schemas defined in OpenAPI spec, but won't enforce complex business logic.

---

## Changelog

**v1.0.0** - Initial release
- Four complete mock APIs
- Comprehensive error trigger system
- Full OpenAPI 3.0 specifications
- Docker Compose configuration

---

**Happy Testing! 🚀**

For questions or issues with mock APIs, contact course support or post in the discussion forum.
