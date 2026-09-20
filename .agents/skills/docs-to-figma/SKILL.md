---
name: docs-to-figma
description: Turn an SRS and related product docs into a minimal, navigable UI overview for approval, then build matching editable Figma screens through MCP. Use after requirements discovery (including grill-with-docs), or to repair screen sprawl, dead ends, excessive copy, and inconsistent design before Figma generation.
---

# Docs to Figma

Deliver a reviewable product interface before spending effort on Figma. The sequence is **ground scope → build and verify overview → user approval → Figma → parity check**. Respond in the user's language.

## Sources and companion skills

- Read `docs/SRS.md`, relevant ADRs, domain glossary, feature docs, and supplied brand/design references. Follow the project's AGENTS.md. Reuse existing UI and design-system assets where relevant.
- Read [frontend-design](../frontend-design/SKILL.md) for art direction, typography, composition, and concise product copy.
- Read [design-taste-frontend](../design-taste-frontend/SKILL.md) for brief inference, contextual design choices, and applicable visual checks. Its landing/portfolio rules do not govern dashboards, dense product UI, multi-step flows, or native mobile. State this boundary when relevant; use platform conventions and the existing product design system for those surfaces. Do not add a landing page just to use this skill.
- User requirements and approved brand/platform constraints win over aesthetic defaults. Do not force dramatic motion, decorative imagery, new themes, a new UI library, or a web stack onto an application just to satisfy a marketing-page checklist.
- Resolve companion skills relative to this skill first, then through the environment's skill catalog. Do not hardcode a developer's home path or assume a `Skill` tool exists. If a required companion is missing, report it; do not claim to have applied it.
- Load Figma skills and discover callable MCP tools only for the relevant phase. Missing Figma access must not block the local overview.

## 1. Ground the UI in real requirements

Distinguish actual project decisions from template examples, placeholders, suggested future work, and unresolved interview notes. A sample Admin role, registration flow, or Order entity in an unfilled SRS is not scope. If there is no usable product brief, request the missing product/actor/core-task information instead of inventing an app. Do not restart the entire requirements interview when the docs already answer it.

Create or update a compact `docs/design/UI-PLAN.md` (reuse the project's equivalent if present). Record source sections/requirement IDs, target platforms, roles, core tasks, scope, and unresolved decisions. Stable local IDs may reference headings when the SRS has none; do not rewrite the SRS solely to introduce IDs. Conflicting requirements that affect permissions or core journeys need user resolution; independent design work may continue with labeled assumptions.

Derive the smallest complete set of UI surfaces from user tasks, not one screen per requirement, entity, CRUD verb, or SRS chapter:

- For each proposed surface record: ID, user task, source, role/guard, surface type, actual entry action, completion/exit action, and relevant states.
- Use an inline state, drawer, dialog, or existing detail screen when it serves the task better than another route. Keep distinct screens when navigation, permissions, complexity, or deep-linking warrants them.
- Map each in-scope requirement to a surface or explicitly mark it as non-UI. Remove unsupported surfaces, not required capability. Record material merge/omit decisions briefly so missing requirements cannot hide behind minimalism.
- Do not invent dashboards, analytics, onboarding, settings, notifications, authentication methods, or admin tools because they are common. Necessary UI glue may be proposed with a reason; new business capability requires scope agreement.

Treat navigation as a directed graph per role and relevant state. Roots are real launch routes, authenticated home routes, or justified external entries such as an email/deep link. Every surface must be reachable from a valid root under its guards; every nonterminal surface needs a usable next, back, cancel, or recovery action. Completion states need a clear finish/return destination. Never add arbitrary menu entries merely to make an orphan reachable.

A screen gallery or reviewer-only role switch is not evidence of product reachability. Check direct links, denied access, empty data, errors, cancellations, and post-save return behavior where relevant. Use the audit procedure in [references/review-contract.md](references/review-contract.md).

## 2. Build a concrete overview

The overview is a locally viewable, high-fidelity interactive prototype, not only a sitemap, prose, wireframes, or a generated picture. Prefer a lightweight HTML/CSS/JS artifact under `docs/design/overview/`, or the existing preview setup when it is simpler. Keep demo state local; production backend implementation is outside this workflow.

Include all proposed screens in a compact review index and render each distinct screen layout. Shared layouts can reuse components. Provide clickable end-to-end core journeys, meaningful role differences, and consequential states as variants rather than multiplying top-level screens. If scope is too large for one review, agree on a named slice and mark omitted areas explicitly; slice approval cannot authorize the rest.

Choose one coherent visual direction grounded in the audience and task. Record named color roles, fonts and fallbacks, type scale, spacing, radii, icons, density, and target viewport sizes in UI-PLAN. Reuse actual brand assets; use realistic, clearly demo data without fabricated claims. Use fonts that support the product language, including Vietnamese diacritics when applicable.

Keep review annotations outside the product UI. Product copy should enable an action, decision, status interpretation, or error recovery. Remove repeated explanations, SRS paragraphs, implementation terminology, decorative labels, and help text that merely repeats a field label. Preserve instructions needed to prevent consequential mistakes.

Make primary actions and navigation work in the prototype. Implement local state transitions for important flows; identify simulated behavior in the review shell. No silent no-op buttons, `href="#"` navigation, or gallery shortcuts masquerading as working journeys. Secondary interactions may be explicitly unavailable with a reason, but not when they are necessary to complete an approved core task.

## 3. Verify, then request approval

Render the overview and inspect screenshots at target viewport sizes. Walk every core journey from its actual entry for each relevant role. Check scope coverage and navigation separately from visual quality. Repair issues before asking the user to review; follow [references/review-contract.md](references/review-contract.md) for evidence and blocking conditions.

If rendering or interaction tools are unavailable, deliver the inspectable artifact and clearly state what is unverified. Do not mark it ready for approval or claim screenshot/interaction checks passed; resolve the limitation or request the missing capability.

Present the preview link/path, a short scope summary, material open decisions, and verification results. Ask for approval of the **specific overview revision and screen set** before any Figma write, including new files, variables, components, captures, or prototype links. This gate is the user's requested workflow; read-only Figma inspection is allowed when useful.

Record revision, artifact fingerprint (commit or content hash covering prototype/assets and UI-PLAN), approved scope/platforms, and the user's actual approval message in UI-PLAN. Never infer approval from elapsed time, a preexisting SRS approval, generic "continue" during design iteration, or approval of colors alone. Explicit approval already given for the same unchanged revision remains valid; do not ask again.

Incorporate requested revisions locally and repeat affected checks. Changes to screen scope, navigation, layout, or visual direction after approval require approval of the changed overview before transferring those changes. Corrections that restore Figma to the approved reference do not require another approval.

## 4. Transfer the approved overview to Figma

Read [references/figma-handoff.md](references/figma-handoff.md) only when this phase begins. Confirm the approved fingerprint still matches. Use the approved prototype, screenshots, tokens, copy, and navigation as the source of truth for UI; the SRS remains the source for behavior. A newly discovered conflict must be resolved explicitly, not silently redesigned in Figma.

Build only the approved scope using Figma MCP. Verify editable structure, visual parity, and prototype reachability. Return Figma links, the screen-to-node mapping, check results, and any unresolved limitation. Never claim Figma completion from successful tool execution alone.
