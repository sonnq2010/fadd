# Structured HTTP Request Audit Logging

Backend uses a shared HTTP middleware to emit one structured audit log per request, including request ID, request/response metadata, latency, errors, and authenticated identity when available. Request IDs are propagated through `context.Context` so business logs inherit them, while request bodies are bounded and sensitive fields are redacted; go-zero's generic access log is disabled to avoid duplicate request logs.
