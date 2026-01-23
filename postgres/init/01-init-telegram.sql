CREATE TABLE IF NOT EXISTS public.telegram_logs_example_one (
    id SERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    user_name TEXT,
    message_text TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.telegram_logs_example_two (
    id SERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    user_name TEXT,
    message_text TEXT,
    button_clicked TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);