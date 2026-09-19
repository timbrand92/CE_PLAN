# W2–W6 proposed-interaction audit and root25 read-back

FOR TIM

The new cards add useful step-by-step work. One proposed entry would incorrectly stop manual section creation without an existing member; the approved card explicitly allows Manual. Recovery also needs tightening so an unknown outcome is inspected before retrying.

---

Read actual structural_w2_w6_interaction_cards.md in full using overlapping bounded reads, root25 A–D, and relevant canonical ST-06, ST-08 and Structural Drawing Journey clauses. No native execution or implementation change. New interaction design remains proposed.

| ID | Priority / disposition | Exact evidence | Required correction |
|---|---|---|---|
| WUX01 | High / open | W6-A step1 “requires selection of existing local drawing element first”; UX06 entry actual member. Canonical ST8-3 says “Where possible” and explicitly allows Manual creation; ST8-4 starts Select member or choose Manual. | Restore visible Manual path without fabricating a member identity. Label unverified entries Manual; preserve actual-member path when available. |
| WUX02 | High / open | UX03 completion requires every requested eligible result to “have a receipt,” but receipt states include Failed and Unknown. | Complete only when every requested result is verified complete; distinguish completed selected operation from entire system containing blocked rows. Failed/Unknown cannot yield Complete. |
| WUX03 | High / open | UX03 Retry offers Failed/Unknown after confirming unchanged selection. | Unknown may already have committed graphics. Require readback and either proven absent output or reviewed resume/repair of exact partial compound before retry. A failure label alone is not absence. Never automatically duplicate. |
| WUX04 | Medium / open | UX03 defines only pre-Apply Cancel despite per-element progress and partial completion. | Specify proposed Stop/Escape during progress: safe boundary, completed work retained or rolled back, truthful receipt, and action Undo scope. No unsupported native guarantee. |
| WUX05 | Medium / open | UX06 Cancel after COPY says no copied view/detail exists; this covers preview before Apply only. | Distinguish precommit proposal from ordinary COPY already completed. Pending relationship cancellation must not falsely promise removal of the existing copy; define unresolved state and separate native Undo. |
| WUX06 | Medium / open | UX05 shows selected identities but does not explicitly include both levels despite its overlapping/repeated-mark scenario. | Display drawing/view/level for endpoint and support; differing/unknown levels require review, not identity inferred from overlap. Preserve separate repeated-mark versus connected-object scope. |
| UX01-A | Closed at proposal level | Root25 B5 now distinguishes draft information, last confirmed result/basis and actual adopted geometry change. | No further correction for this finding. General draft lifecycle is UX08. |
| UX02-A | Partly closed | Root25 C now shows saved and pending override/reasons and explicit Discard behavior. Keep override still says “the explicit manual value” despite two values on screen. | Name Keep pending override versus retain saved override, or explicitly require which value is chosen before review confirmation. Discard and saved-state restoration are now correct. |

UX04 positive background interpretation is closed at proposal level: view/level/evidence, positive opening confirmation, false-void correction, unknown depth, revision and cancellation are concrete and do not infer bearing. UX05 substantially fills pair selection/replacement and scope; WUX06 remains. UX03/UX06 remain open for the material issues above. Existing W3 placement and W4 bracing preserve approved direct routes and command-specific behavior; no numeric design default was added.

ST8-5 also requires the proposed target RC experience to be one visual preview replacing two blind dialogs. Current picker/dialog evidence can be retained but must not supersede that target. Planner was asked to make the distinction explicit alongside the Manual correction.

All findings sent to planner/root. Root25 visual is not audited here and remains pending root readiness. No overall completion conclusion.

## Correction read-back after first report

Actual W2–W6 file reread: WUX01 Manual path and one visual RC target restored; WUX02 Complete requires complete results; WUX04 Stop stops later work and returns partial receipt; WUX05 ordinary completed COPY distinguished; WUX06 drawing/view/level visible. These close at proposal level. WUX03 remains: Failed rows still retry on unchanged selection alone; Failed can also include partial geometry. Require absence or safe resume for both Failed and Unknown, or explicitly define Failed as verified no committed output. Also distinguish completion of the selected eligible operation from full system readiness with blocked rows. Planner notified.

Root25 Keep pending override now names pending value/reason and gives Discard→review route to retain saved override. UX02-A closed at proposal level.
