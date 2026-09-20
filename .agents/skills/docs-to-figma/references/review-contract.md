# Overview review contract

Use this when validating the overview and recording evidence in UI-PLAN. Keep one compact plan; do not create a separate report for every check.

## Minimal record

Record revision/status (`draft`, `ready-for-review`, `approved`, `transferring`, `verified`), source references, intended platforms/roles, and scope. Use these tables or an equally compact representation:

| Surface ID | Task / requirement source | Role / guard | Screen or embedded state | Entry action / origin | Outcome / exit |
|---|---|---|---|---|---|

| Requirement | Surface IDs or non-UI reason | Covered / blocked |
|---|---|---|

| From / state | User action | Guard | To / state | Back, cancel, or recovery |
|---|---|---|---|---|

Use real actions such as “Select a record in Results”; “from dashboard” alone is insufficient. External roots need a source and fallback, such as “email reset link; expired link → request new link.” A modal shares its parent's route but still needs an opening control and dismissal behavior.

Keep assumptions, meaningful excluded/merged surfaces, tokens, and verification evidence alongside these tables. Record screenshots or preview locations and the journey outcomes actually observed, not just checkmarks.

## Scope and navigation audit

1. Reconcile requirement coverage in both directions: no unsupported UI surface, no forgotten in-scope UI requirement. Non-UI requirements should not spawn explanatory pages.
2. Enumerate roots per role. Follow real controls through reachable surfaces and states, respecting permissions and prerequisites. An edge usable only by an administrator does not make a member screen reachable.
3. Check every surface against the reached set. A cycle disconnected from every root is still an orphan, even though all its nodes have incoming edges.
4. Walk the core task to its outcome. Verify cancel/back, validation correction, empty-state next action, retry, and return after success when relevant. Handle an inaccessible deep link without stranding the user.
5. Compare the declared edges with actual prototype controls. A diagram arrow without a working control is not a pass. Reviewer-only selectors must be visually separate and excluded from the reachability result.

For a large graph, a small traversal script can check structural reachability, but it does not replace walking the rendered controls or evaluating guards.

## Visual and copy audit

Inspect all distinct layouts at intended sizes; inspect shared variants when content, permissions, or responsive behavior changes the layout. Check:

- Clear task hierarchy and primary action; navigation reflects the current location.
- Consistent typography, spacing, alignment, component states, and semantic colors.
- Appropriate information density, usable targets, readable contrast and labels, visible focus, keyboard flow, and reduced motion where relevant.
- No clipped text, overflowing content, missing assets, font fallback surprises, or broken Vietnamese diacritics.
- Long realistic names, empty results, and errors do not break the layout.
- Each visible explanation helps the user act or decide; reviewer rationale stays outside the UI.
- Visual choices fit this product and platform. A fashionable palette or landing-page hero is not evidence of professional application design.

Apply relevant companion-skill checks without importing unrelated marketing requirements. Fix concrete defects and rerender affected views. Do not use a numerical “beauty score” as proof.

## Approval readiness

Blocking issues: unresolved scope/role decisions affecting the reviewed slice, missing requirement coverage, orphan surfaces, broken core controls, missing outcomes/recovery, unreadable/overlapping content, and unperformed render or journey checks. Resolve these before marking ready.

Approval prompt should identify the revision, screen set, preview, and next action: for example, “Bạn duyệt overview v2 với các màn hình đã liệt kê để tôi dựng đúng bản này trên Figma chưa?” If the answer includes changes, apply them and obtain approval for the revised result rather than treating the request as blanket approval.
