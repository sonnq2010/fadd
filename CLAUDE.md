# Commands
- `make verify`: Verify the consistent state of project

# Should 
- Follow YAGNI principles
- Be concise and easy for humans to understand. If you're about to write something a human wouldn't understand, better not write it.
- Provide the code snippets related to the functionality when declaring the task complete

# Do not
- 

# At session start (clock in)
1. Read docs/adr/ for important decisions

# Before compacting session
1. Update docs/features/<feature_name>/PROGRESS.md
2. Run `make verify` to confirm consistent state

# Resuming after compaction
1. Read docs/features/<feature_name>/PROGRESS.md for current state
3. Run `make verify` to confirm repo is in consistent state
4. Continue from docs/features/<feature_name>/PROGRESS.md "Next Steps" section

# Definition of Done
- All lint + typecheck passed
- All test passed

## Validation Hierarchy
- Level 1: Unit tests (Must pass)
- Level 2: Integration tests (Must pass)
- Level 3: End-to-end tests (Must pass when cross-component changes are involved)
- Skipping any required level = Not Complete
