# Mock API Quick Reference

Quick reference for all mock API endpoints, error triggers, and common use cases.

## Base URLs

- **Telecom CRM:** `http://localhost:4010`
- **Billing System:** `http://localhost:4011`
- **Network Management:** `http://localhost:4012`
- **Geolocation:** `http://localhost:4013`

---

## Telecom CRM API (Port 4010)

### Get Customer Profile
```
GET /api/v1/customers/{customer_id}
```
**Examples:**
- `AB123456` → Normal customer
- `VIP789` → VIP customer
- `error404` → 404 Not Found
- `error500` → 500 Internal Server Error
- `timeout` → 30 second delay

### Get Credit Score
```
GET /api/v1/customers/{customer_id}/credit-score
```
**Examples:**
- `AB123456` → Good score (720)
- `AB000` → Poor score (<500)
- `AB999` → Excellent score (>800)

### Check Blacklist Status
```
GET /api/v1/customers/{customer_id}/blacklist-status
```
**Examples:**
- `AB123456` → Not blacklisted
- `BLOCKED123` → Blacklisted
- `FRAUD456` → Blacklisted with fraud flag

### Create Customer
```
POST /api/v1/customers
Body: {
  "name": "Jane Smith",
  "email": "jane@example.com",
  "phone_number": "+447700900789",
  "id_number": "CD789012",
  "address": "123 Main St"
}
```

---

## Billing System API (Port 4011)

### Create Account
```
POST /api/v1/accounts
Body: {
  "customer_id": "AB123456",
  "account_type": "prepaid",
  "currency": "USD",
  "initial_balance": 50.00
}
```

### Get Balance
```
GET /api/v1/accounts/{account_id}/balance
```
**Examples:**
- `ACC-2026-001` → Normal balance
- `insufficient` → Very low balance (2.50)

### Charge Account
```
POST /api/v1/accounts/{account_id}/charge
Body: {
  "amount": 25.00,
  "description": "Monthly subscription",
  "reference_id": "SUB-2026-02"
}
```
**Error Triggers:**
- `account_id=insufficient` → 402 Payment Required
- `amount > 10000` → 400 Bad Request (exceeds limit)

### Process Payment
```
POST /api/v1/payments
Body: {
  "account_id": "ACC-2026-001",
  "amount": 50.00,
  "payment_method": "credit_card",
  "card_number": "4111111111111111",
  "card_expiry": "12/27",
  "cvv": "123"
}
```
**Error Triggers:**
- `payment_method=invalid` → 400 Bad Request

### Get Transaction History
```
GET /api/v1/accounts/{account_id}/transactions?limit=10&offset=0
```

---

## Network Management API (Port 4012)

### Provision SIM
```
POST /api/v1/sim/provision
Body: {
  "customer_id": "AB123456",
  "sim_type": "eSIM",
  "plan_id": "PLAN-UNLIMITED-5G",
  "iccid": "89440000000123456789"
}
```
**Error Triggers:**
- `sim_type=unknown` → 400 Bad Request

### Get Active Outages
```
GET /api/v1/network/outages?severity=critical&region_id=NORTH-01
```

### Resolve Outage
```
POST /api/v1/network/outages/{outage_id}/resolve
Body: {
  "resolution_notes": "Fiber repaired",
  "actual_resolution_time": "2026-02-16T17:45:00Z"
}
```

### Check Network Coverage
```
GET /api/v1/network/coverage?latitude=51.5074&longitude=-0.1278
```

### Activate Roaming
```
POST /api/v1/roaming/activate
Body: {
  "phone_number": "+447700900123",
  "country_code": "FR",
  "package_id": "ROAM-EU-7DAY"
}
```

### Deactivate Roaming
```
POST /api/v1/roaming/deactivate
Body: {
  "phone_number": "+447700900123"
}
```

### Get Roaming Usage
```
GET /api/v1/roaming/{phone_number}/usage
```

### Get Device Telemetry Config
```
GET /api/v1/devices/{device_id}/telemetry
```
**Examples:**
- `IMEI-88223344` → Normal device
- `error500` → 500 Internal Server Error

### Throttle Device
```
POST /api/v1/devices/{device_id}/throttle
Body: {
  "throttle_speed_kbps": 64,
  "reason": "Data limit exceeded"
}
```

### Send Device Command
```
POST /api/v1/devices/{device_id}/command
Body: {
  "command": "reboot"
}
```
**Available commands:** `reboot`, `update_firmware`, `suspend`, `resume`, `locate`

---

## Geolocation & Enrichment API (Port 4013)

### Geographic Lookup
```
GET /api/v1/geo/lookup?zip=10111
GET /api/v1/geo/lookup?ip=8.8.8.8
GET /api/v1/geo/lookup?latitude=51.5074&longitude=-0.1278
```

### Get Region Information
```
GET /api/v1/region/{region_id}/info
```
**Examples:**
- `NORTH-01` → Urban region
- `SOUTH-05` → Rural region
- `error404` → 404 Not Found
- `maintenance` → 503 Service Unavailable

### Get Company Data
```
GET /api/v1/company/{company_name}/data
```
**Examples:**
- `TechCorp Solutions` → Enterprise company
- `StartupXYZ` → Small startup
- `MidMarket Corp` → Mid-market company

**Note:** URL-encode company names with spaces: `TechCorp%20Solutions`

### Get Roaming Partners
```
GET /api/v1/roaming/partners?country=FR
GET /api/v1/roaming/partners?country=DE
```
**Error Triggers:**
- `country=XX` → 404 Not Found (unsupported)

---

## Common Error Patterns

### Testing 404 Errors
Use `error404` as ID in any endpoint:
```
GET http://localhost:4010/api/v1/customers/error404
GET http://localhost:4013/api/v1/region/error404/info
```

### Testing 500 Errors
Use `error500` as ID:
```
GET http://localhost:4010/api/v1/customers/error500
GET http://localhost:4012/api/v1/devices/error500/telemetry
```

### Testing Timeout
Use `timeout` as ID:
```
GET http://localhost:4010/api/v1/customers/timeout
```
Response delayed 30 seconds.

### Testing Validation Errors (400)
- Invalid formats: non-alphanumeric IDs
- Exceeding limits: `amount > 10000`
- Unknown values: `sim_type=unknown`
- Invalid methods: `payment_method=invalid`

### Testing Insufficient Funds (402)
```
GET http://localhost:4011/api/v1/accounts/insufficient/balance
POST http://localhost:4011/api/v1/accounts/insufficient/charge
```

### Testing Service Unavailable (503)
```
GET http://localhost:4013/api/v1/region/maintenance/info
```

---

## n8n Integration Examples

### HTTP Request Node - Get Customer
```
Method: GET
URL: http://localhost:4010/api/v1/customers/{{$json.customer_id}}
Authentication: None
Retry On Fail: Yes (3 attempts)
```

### HTTP Request Node - Create Account
```
Method: POST
URL: http://localhost:4011/api/v1/accounts
Body Content Type: JSON
Body:
{
  "customer_id": "{{$json.customer_id}}",
  "account_type": "prepaid",
  "currency": "USD",
  "initial_balance": 50.00
}
```

### HTTP Request Node - With Error Handling
```
Node Settings:
- Continue On Fail: true
- Retry On Fail: true
- Max Attempts: 3
- Wait Between Tries: 2000ms

Expression to check success:
{{ $json.status_code === 200 }}
```

---

## Testing Checklist

### Happy Path Tests
- [ ] Customer lookup returns valid data
- [ ] Account creation succeeds
- [ ] Payment processing completes
- [ ] SIM provisioning returns phone number
- [ ] Balance check returns current amount

### Error Handling Tests
- [ ] 404 errors caught by Error Workflow
- [ ] 500 errors trigger retry logic
- [ ] Validation errors (400) handled gracefully
- [ ] Insufficient funds (402) creates alert
- [ ] Timeout triggers fallback behavior

### Integration Tests
- [ ] Sequential API calls work
- [ ] Data flows between mock APIs and PostgreSQL
- [ ] Error notifications sent via Telegram
- [ ] State transitions logged correctly
- [ ] Audit trail complete

---

## Useful curl Commands

### Test Telecom CRM
```bash
curl http://localhost:4010/api/v1/customers/AB123456
curl http://localhost:4010/api/v1/customers/AB123456/credit-score
curl http://localhost:4010/api/v1/customers/BLOCKED123/blacklist-status
```

### Test Billing
```bash
curl http://localhost:4011/api/v1/accounts/ACC-2026-001/balance

curl -X POST http://localhost:4011/api/v1/accounts \
  -H "Content-Type: application/json" \
  -d '{"customer_id":"AB123456","account_type":"prepaid","currency":"USD","initial_balance":50}'
```

### Test Network Management
```bash
curl http://localhost:4012/api/v1/network/outages

curl -X POST http://localhost:4012/api/v1/sim/provision \
  -H "Content-Type: application/json" \
  -d '{"customer_id":"AB123456","sim_type":"eSIM","plan_id":"PLAN-01"}'
```

### Test Geolocation
```bash
curl "http://localhost:4013/api/v1/geo/lookup?zip=10111"
curl http://localhost:4013/api/v1/region/NORTH-01/info
curl "http://localhost:4013/api/v1/roaming/partners?country=FR"
```

---

## Response Time Reference

All mocks respond instantly (<50ms) except:
- `customer_id=timeout` → 30 seconds
- Large batch operations → ~100-200ms

This allows testing both fast responses and timeout scenarios.

---

## Tips

1. **Keep Swagger UI Open:** Browse to each port to see interactive docs
2. **Test Errors First:** Verify error handling works before happy path
3. **Use Fixed Values:** Test with hardcoded values before using expressions
4. **Log Everything:** Store all API responses in PostgreSQL for debugging
5. **Check Response Codes:** Don't just check success, verify specific codes

---

For complete API documentation, see:
- `mock-apis/telecom-crm/openapi.yaml`
- `mock-apis/billing-system/openapi.yaml`
- `mock-apis/network-management/openapi.yaml`
- `mock-apis/geolocation/openapi.yaml`

Or browse Swagger UI at http://localhost:4010-4013 when mocks are running.
