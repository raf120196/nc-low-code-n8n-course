# Week 2 Exercises: Data Manipulation & Logic

## Task Overview
Choose one of the following options to practice data manipulation and logic in n8n.

### Option 1: User Data Transformation
**Goal:** Filter and transform a list of users.
1. Use a **Code Node** or **Edit Fields** to create a mock list of users (at least 5) with fields: `firstName`, `lastName`, and `age`.
2. Use a **Filter Node** to keep only users with `age > 18`.
3. Use an **Edit Fields Node** to create a new field `fullName` by combining `firstName` and `lastName`.

### Option 2: Product Categorization
**Goal:** Categorize products based on price.
1. Create a list of products with `name` and `price`.
2. Use a **Switch Node** to route products into three categories:
   - **Cheap:** Price < $10
   - **Medium:** Price $10 - $50
   - **Expensive:** Price > $50
3. Use **Edit Fields** after each branch to add a `category` field with the corresponding label.

### Option 3: Statistical Analysis (JavaScript)
**Goal:** Calculate basic statistics from an array of numbers.
1. Create a workflow that receives an array of numbers (e.g., `[10, 20, 30, 40, 50]`).
2. Use a **Code Node** (JavaScript) to calculate:
   - `average`
   - `min`
   - `max`
3. Return a single JSON object with these three values.

### Option 4: JSON Flattening
**Goal:** Simplify a nested JSON structure.
1. Start with a nested JSON object (e.g., `{ "user": { "profile": { "name": "John", "email": "john@example.com" } } }`).
2. Use the **Edit Fields Node** to "flatten" it so that `name` and `email` are at the top level.

### Option 5: Order Processing
**Goal:** Filter and calculate revenue from orders.
1. Create a list of orders with `id`, `status` ("completed", "cancelled"), `price`, and `quantity`.
2. Filter out all "cancelled" orders.
3. Use **Edit Fields** to calculate `revenue` (`price * quantity`) for each remaining order.

## Submission
- Export your workflow as a `.json` file.
- Save it in this folder as `week-2-solution.json`.
