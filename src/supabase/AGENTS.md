# Commands

- `make start`: Start Supabase local stack (Docker).
- `make stop`: Stop Supabase local stack.
- `make restart`: Restart Supabase local stack.
- `make status`: Show local URL, anon key, and service role key.
- `make migration-new name=<name>`: Create a new empty migration file.
- `make migration-up`: Apply pending migrations to the local database.
- `make migration-down n=<count>`: Roll back the last `n` migrations (defaults to 1).
- `make migration-list`: List applied and pending migrations.
- `make db-reset`: Drop and recreate the local database, replaying all migrations and `seed.sql`.
- `make functions-new name=<name>`: Create a new Edge Function.
- `make functions-serve`: Run all Edge Functions locally.
