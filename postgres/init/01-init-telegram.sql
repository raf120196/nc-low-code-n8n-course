CREATE TABLE IF NOT EXISTS public.telegram_logs (
    id SERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    user_name TEXT,
    button_clicked TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);