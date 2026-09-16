# AGI — line-only drafting sequence

FOR TIM

Draw the AGI route and review its drafting appearance. The settled window has no diameter, grade or level fields. The drawn line does not by itself prove a connected or sized drainage system.

## Authority and actual source

The approved Drainage Items handover retains AGI on Main as line-only with drafting appearance controls. Retain CDAGI; no new aliases or engineering fields. Source observations below qualify the existing implementation and do not redesign the active owner.

Read root `Modules/Drainage/Commands/AgiCommand.cs` in two overlapping output reads (the first combined output was truncated; remainder was read separately). The caller collects vertices, commits a polyline, then adds a non-schedule AGI PitData record and calls RegisterPit/RelinkAllPipeEndpoints. This source storage/call pattern is not permission to reinterpret the settled line-only interface as a pit editor or inferred hydraulic design.

| Actual inspected behaviour | Planning consequence |
|---|---|
| InitServicesFull/layer setup and EnsureAgLineLinetypePresent precede the point prompts | Cancel of the route is not proof that no setup/import effect occurred. |
| Actual linetype helper checks current drawing, attempts a named template import and throws if AG_LINE remains absent | Older file-summary comments mentioning HIDDEN fallback are not the actual helper's behaviour. Preserve honest missing-style feedback; do not claim the preferred style was drawn after substitution. No template/master was opened by this planning run. |
| Enter returns a route only with at least two vertices; Close keyword available after three; Undo removes last vertex or cancels at first | Retain familiar distinct open/closed/Undo gestures. No arbitrary polygon-only restriction. |
| Caller also treats near-coincident first/last points as closed and removes last point before output | Preview actual intended closure, not only the keyword used. Native tolerance/units behaviour remains unproved; no new tolerance is approved. |
| Tag allocator scans currently present project IDs for highest AGI suffix | This read does not prove durable non-recycling after deletion or concurrent safe allocation. Preserve approved identity rules; do not infer complete identity safety from the next-number appearance. |
| Polyline commits before project registration; centroid/remarks recorded separately | A visible route is not a fully verified saved record. Later failure may need readback before retry. Vertex-average position is not an outlet or confirmed pipe endpoint. |

No native command, template import, source write or provider/client-data operation occurred.

## Proposed ordinary journey

1. Main → AGI or retained CDAGI. Show drafting appearance from the actual supported owner settings and the route preview. Do not add engineering diameter, grade or levels to fill visual space.
2. Draw first/next points. Preview the intended AG_LINE appearance at the real drawing scale; preserve supported snaps/UCS. Undo a mistaken point; Enter finishes a valid open route; Close deliberately closes a valid loop. Actual source's coincident-end closure must be visible before acceptance.
3. Inspect route identity and presentation. Display missing or fallback assets honestly. No similar-looking line or centroid is treated as a confirmed hydraulic connection.
4. Accept the reviewed output through the existing owner. Distinguish actual route geometry, registration/identity and any separately confirmed relationship. Retain the ordinary direct drafting command rather than forcing CDDESIGN setup for a line.
5. When changing appearance or vertices, select the exact local owned route and preview affected presentation. Respect protected/Xref content. An appearance edit does not authorise network recalculation, level assignment or nearby endpoint relinking.

The exact drafting controls exposed beyond the settled appearance requirement remain owner-qualified; this card does not invent a new colour/linetype catalogue. Any deliberate network relationship uses the shared reviewed network route and stable identities, separate from the line-only controls.

## Example and boundaries

Draw an open AGI route beside a footing, undo one point, then finish with Enter. The preview shows its actual line appearance without a diameter or RL box. Draw another route back toward its starting point and review whether it is closing. If AG_LINE is missing, see the actual asset problem rather than silently receiving a different graphic. A later registration error must not trigger a second coincident AGI line.

Move/copy/remove follows the approved compound/identity and selected-scope rules. No automatic catchment or destination relationship follows from crossing a pipe. Save/reopen must prove actual route identity and presentation, not just the fact it still looks dashed.

Future native qualification: open/closed and coincident-end routes, point Undo/Cancel, style availability/import side effects, actual line scale/UCS, tag persistence, partial registration, protected selections, copy and reopen. Not executed; planning/source evidence only.
