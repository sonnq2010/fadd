# Approved overview to Figma

Use only after explicit approval of the reviewed overview. No new visual exploration or inferred product scope in this phase.

## Discover capabilities and target

Discover the installed Figma MCP tools and skills through the current environment. Load `figma-generate-design` and `figma-use` before their operations. Load `figma-create-new-file` before creating a file, and `figma-generate-library` when creating components/variants or token foundations. Use platform-specific guidance where applicable. Tool schemas and these skills govern current API mechanics; do not invent endpoints or tool arguments.

Reuse a user-specified destination. If none is given, ask whether to use an existing file or create a new one; prepare mappings while awaiting the target. Do not modify an arbitrary recent file. If MCP is disconnected or a required capability is absent, preserve the approved local artifacts, state the exact blocker, and resume after access is available. Do not replace requested MCP execution with instructions and call it complete.

## Match the approved reference

1. Inspect existing target pages, libraries, styles, variables, components, and relevant Code Connect mappings. Compare these with approved tokens. Reuse compatible assets; surface material conflicts instead of silently changing the approved design.
2. For an empty file, create only the foundations and component variants used by the approved screens. No speculative full component library.
3. Build editable frames, text, auto layout, reusable component instances, semantic token bindings, and real vector/image assets. A pasted screenshot is a reference, not the deliverable. Follow the active Figma skill's capture/import workflow when supported and appropriate to the source.
4. Maintain a mapping of approved surface/state IDs to Figma node IDs and URLs in UI-PLAN. Distinguish screen frames, state variants, and reference captures; variants are not additional product routes.
5. Wire entry points, navigation, overlays, back/cancel, and task completion in Figma prototypes where MCP supports them. Provide starting points for role-specific journeys. Check destinations against node IDs actually created. If a necessary interaction cannot be represented or verified, record the missing behavior and report the prototype as incomplete, even if static screens are finished.

Work in small inspectable batches. On interruption or uncertain tool results, read the target and existing node mapping before retrying; update existing nodes rather than duplicating pages/screens. Remove only temporary reference nodes created by this run after they are no longer needed. Preserve unrelated user content.

## Parity gate

Capture Figma screenshots and compare with the approved overview at equal viewport/frame dimensions. Inspect both full screens and details that scaled thumbnails hide: font family and weight, line wraps, spacing, colors, asset crops, labels, states, and component variants. Correct drift against the approved reference rather than editing the reference to justify drift.

Reconcile the final screen set and role-aware navigation with UI-PLAN. Verify actual prototype links and starting points, not merely the flow diagram. Record observed results, screenshot locations, node links, and any tool-limited checks. Completion requires verified parity and navigation within the approved slice; disclose partial results without claiming full completion.
