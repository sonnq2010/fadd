.PHONY: start stop restart status \
        migration-new migration-up migration-down migration-list db-reset \
        functions-new functions-serve

start:
	supabase start

stop:
	supabase stop

restart: stop start

status:
	supabase status

migration-new:
	supabase migration new $(name)

migration-up:
	supabase migration up

migration-down:
	supabase migration down --last $(or $(n),1)

migration-list:
	supabase migration list

db-reset:
	supabase db reset

functions-new:
	supabase functions new $(name)

functions-serve:
	supabase functions serve