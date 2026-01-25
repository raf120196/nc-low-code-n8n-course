# Week 3 Exercises: External APIs & Messaging

## Task Overview
Choose one of the following options to practice working with APIs and Telegram.

### Option 1: Random Cat Bot
**Goal:** Fetch and send a random cat image.
1. Create a Telegram bot using `@BotFather`.
2. Use the **HTTP Request Node** to fetch a random image from `https://api.thecatapi.com/v1/images/search`.
3. Use the **Telegram Node** to send the image URL to your chat.

### Option 2: Weather Bot
**Goal:** Get current weather for a city.
1. Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/api).
2. Create a workflow that triggers via a Telegram message (city name).
3. Fetch the weather data for that city using the **HTTP Request Node**.
4. Send a formatted message back to Telegram (e.g., "The temperature in London is 15°C").

### Option 3: News Aggregator
**Goal:** Fetch and format a list of posts.
1. Use the **HTTP Request Node** to fetch the latest 5 posts from `https://jsonplaceholder.typicode.com/posts`.
2. Use the **Edit Fields Node** or **Code Node** to format these posts into a single readable string.
3. Send the formatted list to a Telegram channel or chat.

### Option 4: Translation Bot
**Goal:** Translate text using an API.
1. Use a free translation API (like `LibreTranslate` or similar).
2. Create a workflow where a user sends a message in English, and the bot replies with the translation in another language.

### Option 5: Website Uptime Monitor
**Goal:** Alert if a website is down.
1. Use the **HTTP Request Node** to check the status of a website (e.g., `https://google.com`).
2. Use an **If Node** to check if the status code is `200`.
3. If it's NOT `200`, send an alert message to Telegram.

## Submission
- Export your workflow as a `.json` file.
- Save it in this folder as `week-3-solution.json`.
