# Final Project Specifications

## Overview
The final project is the culmination of the "Low-Code Engineering with n8n" course. Students must design, implement, and document a complex automated system using n8n and at least two external integrations (e.g., Telegram, PostgreSQL, Google Sheets, or an external API), specifically tailored for the **Telecommunications Industry**.

## Requirements
1. **Complexity:** The workflow must contain at least 10 nodes and include logic (Switch, Filter, or Code nodes).
2. **Data Persistence:** The system must store or retrieve data from a database (PostgreSQL) or a spreadsheet (Google Sheets).
3. **Data Enrichment:** The workflow must include at least one **Data Enrichment** step, where initial input is supplemented with additional information from an external Mock API.
4. **Data Transformation:** Use **Item Lists**, **Set**, or **Code Node** to transform data between different formats (e.g., converting flat JSON to a nested structure for an API).
5. **Security:** Use **Environment Variables** for all sensitive data (API keys, database credentials). No secrets should be hardcoded in the nodes.
6. **Error Handling & Resilience:** 
    - At least one critical node must have **Retry logic** enabled (e.g., for HTTP Requests).
    - The workflow must include a **Global Error Trigger** or specific error paths (using the "On Error" node setting) to notify the admin/user if something fails.
7. **Documentation:** A `README.md` file explaining:
    - The problem the workflow solves.
    - A list of nodes used.
    - Setup instructions (environment variables, credentials).
    - A high-quality screenshot of the final workflow (use **Sticky Notes** in n8n to annotate different parts of the logic).

## Data Intake Methods (How to start your workflow)
For any topic below, you must choose **one** of these methods to trigger your workflow:
- **n8n Form Trigger:** Create a native web form within n8n.
- **Telegram Trigger:** Create a bot that receives commands or messages.
- **Webhook Node:** Use an external tool (like Tally.so or Postman) to send a POST request.

---

## Project Topics (Choose One or Propose Your Own)

### Topic 1: SIM Card Purchase & Activation
**Goal:** Automate the full lifecycle of a SIM card order.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `customer_name` | String | Full name of the customer | "John Doe" |
| `customer_email` | String | Contact email for notifications | "john.doe@example.com" |
| `id_number` | String | National ID or Passport number | "AB123456" |
| `sim_type` | String | Physical SIM or eSIM | "eSIM" |
| `plan_name` | String | Name of the selected tariff plan | "Unlimited Ultra 5G" |

**2. Sequence of Actions:**
1. **Trigger:** Receive data via n8n Form or Webhook.
2. **Enrichment:** HTTP Request to `https://mock.api/v1/customer-profile?id=id_number` to fetch `credit_score` and `is_blacklisted`.
3. **Validation:** Use an **IF** node to check if `is_blacklisted` is false and `id_number` is valid.
4. **Persistence:** Insert a record into `orders` table in **PostgreSQL**.
5. **Composite Activation (Mock API calls):**
    - **Step A (Provisioning):** Reserve phone number.
    - **Step B (HLR Update):** Register SIM in network.
    - **Step C (Billing Setup):** Create billing account.
6. **Update Status:** Update PostgreSQL record to `activated`.
7. **Notification:** Send confirmation via email or Telegram.

**3. Error Handling & Retry:**
- **Retry Logic:** Enable on all HTTP Request nodes.
- **Error Path:** If enrichment or activation fails, update DB to `failed` and alert Support via Telegram.

**4. Complexity Note:**
- Requires handling multiple sequential API calls for provisioning and updating database states based on success/failure.

---

### Topic 2: Home Internet/TV Provisioning
**Goal:** Manage the technical setup and scheduling for home services.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `customer_name` | String | Full name of the customer | "Alice Smith" |
| `address` | String | Installation service address | "123 Fiber St, Tech City" |
| `zip_code` | String | Area postal code for availability check | "10111" |
| `service_type` | String | Type of service (Internet, TV, or Bundle) | "Fiber Internet + TV" |

**2. Sequence of Actions:**
1. **Trigger:** Receive data via Webhook or n8n Form.
2. **Enrichment:** HTTP Request to `https://mock.api/v1/geo-data?zip=zip_code` to fetch `nearest_hub_id` and `infrastructure_type` (Fiber/Copper).
3. **Availability Check:** Look up `zip_code` in **Google Sheet**.
4. **Account Creation:** Create record in **PostgreSQL**.
5. **Composite Provisioning (Mock API calls):**
    - **Step A (Line Test):** Verify physical connection.
    - **Step B (ONT Activation):** Enable home terminal.
    - **Step C (Service Binding):** Link account to `nearest_hub_id`.
6. **Scheduling:** Assign date using **Code Node**.
7. **Logistics:** Notify Telegram "Warehouse" with `infrastructure_type` details.
8. **Customer Update:** Notify customer via Telegram.

**3. Error Handling & Retry:**
- **Retry Logic:** Enable for Google Sheet and Line Test nodes.
- **Error Path:** Log failures in "Technical Issues" Google Sheet.

**4. Complexity Note:**
- Involves cross-referencing data between a database (PostgreSQL) and a spreadsheet (Google Sheets), plus technical logic for scheduling.

---

### Topic 3: Telecom Support Bot with Billing Integration
**Goal:** Self-service bot for balance management and technical support.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `phone_number` | String | Subscriber's MSISDN | "+447700900123" |
| `request_type` | String | Action to perform (Balance, Top-up, Support) | "Top-up" |
| `topup_amount` | Number | Amount to add to balance (if Top-up) | 25.50 |

**2. Sequence of Actions:**
1. **Trigger:** **Telegram Bot** receives message.
2. **Authentication:** Query **PostgreSQL** to find user.
3. **Enrichment:** HTTP Request to `https://mock.api/v1/subscriber-details?phone=phone_number` to fetch `loyalty_status` and `current_data_bonus`.
4. **Logic Branching (Switch Node):**
    - **Case "Balance":** GET balance and include `current_data_bonus` in the response.
    - **Case "Top-up":** 
        - **Composite Payment:** Authorize -> Credit Account.
        - If `loyalty_status` is "Gold", add 10% extra credit.
    - **Case "Support":** Check for outages. If none, log ticket in **Google Sheets**.

**3. Error Handling & Retry:**
- **Retry Logic:** Enable for Payment Authorization.
- **Error Path:** Notify user of temporary unavailability via Telegram.

**4. Complexity Note:**
- Uses a **Switch Node** for multi-path logic and implements conditional "loyalty" bonuses using expressions or a Code Node.

---

### Topic 4: Network Outage Monitor & Customer Alerting
**Goal:** Proactive communication during service disruptions.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `region_id` | String | Unique identifier of the affected region | "NORTH-01" |
| `severity` | String | Impact level (Critical, Major, Minor) | "Critical" |
| `estimated_resolution` | String | Expected time to fix the issue | "2026-01-25 18:00" |

**2. Sequence of Actions:**
1. **Trigger:** **Schedule Node** or **Webhook**.
2. **Outage Fetch:** GET active outages from Mock API.
3. **Enrichment:** For each `region_id`, HTTP Request to `https://mock.api/v1/region-info?id=region_id` to fetch `critical_infrastructure_count` and `local_manager_contact`.
4. **Impact Analysis:** Query **PostgreSQL** for customers in the region.
5. **Composite Communication:**
    - **Step A (Internal Alert):** Notify "NOC Team" and include `local_manager_contact`.
    - **Step B (Customer Alert):** Personalized Telegram alerts.
    - **Step C (Public Status):** Update **Google Sheet**.
6. **Resolution Check:** Send follow-up when resolved.

**3. Error Handling & Retry:**
- **Retry Logic:** Enable for Outage Fetch.
- **Error Path:** Log failed notifications to Google Sheet.

**4. Complexity Note:**
- Requires iterating over a list of outages and performing nested lookups/notifications for each affected region.

---

### Topic 5: Automated Roaming Package Activation
**Goal:** Real-time upsell based on customer location.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `phone_number` | String | Subscriber's MSISDN | "+447700900123" |
| `country_code` | String | ISO country code where roaming is detected | "FR" |
| `is_roaming` | Boolean | Flag indicating roaming status | true |

**2. Sequence of Actions:**
1. **Trigger:** **Webhook** or **Telegram** location share.
2. **Enrichment:** HTTP Request to `https://mock.api/v1/roaming-partners?country=country_code` to fetch `partner_network_name` and `current_exchange_rate`.
3. **Plan Check:** Query **Google Sheets** for roaming inclusion.
4. **Upsell Decision:** If not included:
    - **Step A (Offer Generation):** GET offer and include `partner_network_name` in the message.
    - **Step B (Interaction):** Send Telegram message with buttons.
5. **Composite Activation (On Accept):**
    - **Step A (Provisioning):** Activate bundle.
    - **Step B (Billing):** Charge account (calculating price with `current_exchange_rate`).
6. **Confirmation:** Update **PostgreSQL** and notify user.

**3. Error Handling & Retry:**
- **Retry Logic:** Enable for Billing Charge.
- **Error Path:** Notify user of error and create high-priority ticket.

**4. Complexity Note:**
- Implements interactive Telegram buttons and handles the "Wait for Webhook" pattern for user confirmation.

---

### Topic 6: B2B Lead Management for Enterprise Solutions
**Goal:** Automate the processing and qualification of corporate service requests.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `company_name` | String | Legal name of the corporate client | "TechCorp Solutions" |
| `contact_person` | String | Name of the person making the request | "Robert Brown" |
| `email` | String | Corporate email address | "r.brown@techcorp.com" |
| `service_requested` | String | Enterprise service type | "Dedicated Fiber" |
| `estimated_users` | Number | Number of employees using the service | 150 |

**2. Sequence of Actions:**
1. **Trigger:** Receive data via **n8n Form** or **Webhook**.
2. **Enrichment:** HTTP Request to `https://mock.api/v1/company-data?name=company_name` to fetch `industry`, `company_size`, and `revenue_tier`.
3. **Qualification Logic:** Use a **Code Node** to score the lead based on `company_size` and `estimated_users`.
4. **Persistence:** 
    - Save lead details to **Google Sheets** (Sales Pipeline).
    - If score > 80, create a high-priority record in **PostgreSQL**.
5. **Notification:** 
    - Send a personalized "Thank You" email with a PDF brochure (Data Enrichment).
    - Notify the Sales Team via **Telegram** if it's a "Hot Lead".

**3. Error Handling & Retry:**
- **Retry Logic:** Enable for Email sending and Company Data lookup.
- **Error Path:** Log failed lead processing in a "Dead Letter" Google Sheet.

**4. Complexity Note:**
- Features custom scoring logic in a Code Node and multi-channel notifications based on calculated priority.

---

### Topic 7: IoT Device Management & Alerting
**Goal:** Monitor and manage a fleet of IoT SIM cards for enterprise clients.

**1. Data Intake (Exact Fields):**
| Field | Type | Description | Example |
| :--- | :--- | :--- | :--- |
| `device_id` | String | Unique hardware identifier of the IoT device | "IMEI-88223344" |
| `current_lat` | Number | Current latitude coordinate | 48.8584 |
| `current_long` | Number | Current longitude coordinate | 2.2945 |
| `data_usage_mb` | Number | Amount of data consumed in MB | 450.2 |
| `status` | String | Current operational status | "Active" |

**2. Sequence of Actions:**
1. **Trigger:** **Webhook** receiving telemetry data from devices.
2. **Enrichment:** HTTP Request to `https://mock.api/v1/device-inventory?id=device_id` to fetch `client_id`, `geofence_radius`, and `data_limit`.
3. **Geofence Check:** Use a **Code Node** to calculate if the device is outside its allowed radius.
4. **Usage Validation:** **IF** node to check if `data_usage_mb` > `data_limit`.
5. **Action Branching:**
    - **Case "Out of Bounds":** Send critical alert to client via **Telegram**.
    - **Case "Over Limit":** 
        - **Composite Action:** Throttle speed (Mock API) -> Update status in **PostgreSQL**.
6. **Logging:** Update **Google Sheet** with daily telemetry summary.

**3. Error Handling & Retry:**
- **Retry Logic:** Enable for Device Inventory lookup.
- **Error Path:** Notify the "IoT Operations" team via Telegram if telemetry processing fails.

**4. Complexity Note:**
- Handles real-time telemetry processing, mathematical calculations for geofencing, and automated device state management.

## Timeline
- **Week 5:** Project proposal submission.
- **Week 6:** Initial prototype and feedback.
- **Week 7:** Final presentation and submission.
