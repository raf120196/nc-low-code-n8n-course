# Week 2: Data Manipulation & Logic (Core Nodes)

## Overview
In this module, you will learn how to handle, transform, and route data within n8n workflows. Understanding data structures and core nodes is essential for building complex automations.

## 1. Data Types in n8n
n8n primarily works with two types of data:
- **JSON (JavaScript Object Notation):** The standard format for structured data (objects, arrays, strings, numbers).
- **Binary:** Used for files (images, PDFs, documents).

## 2. Core Nodes for Data Manipulation
- **Edit Fields (Set):** Used to add, remove, or modify fields in the JSON data.
- **Filter:** Allows you to continue the workflow only if certain conditions are met.
- **Switch:** Routes data to different paths based on specific values or conditions.
- **Code Node:** Allows you to write custom JavaScript to perform complex data transformations that are difficult to achieve with standard nodes.

## 3. n8n Expressions
Expressions allow you to dynamically access data from previous nodes.
- Syntax: `{{ $json.field_name }}`
- You can use JavaScript methods within expressions, e.g., `{{ $json.name.toUpperCase() }}`.

## 4. Data Structure
n8n processes data as an array of objects. Each object in the array represents one "item" that flows through the nodes.

## Recommended Reading
- [n8n Expressions Guide](https://docs.n8n.io/code/expressions/)
- [Data structure in n8n](https://docs.n8n.io/concepts/data-structure/)
- [JavaScript for n8n (Code Node)](https://docs.n8n.io/code/javascript-examples/)
