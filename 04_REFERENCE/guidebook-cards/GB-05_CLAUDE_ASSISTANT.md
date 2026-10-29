# GB-05 Claude assistant: DRAFT card (not approved)

**Builds on** the approved Ask CE plan (`docs/CARDS/AI-01_ASK_CE_MCP_AUTOMATION.md`, AI1 to AI15; summary in `04_REFERENCE/civil-system-design-2026-09-16/CIVIL_SYSTEM_DESIGN_2026-09-16/whole-plugin/10_ASSISTANT_AND_CLOUD_RECOVERY.md`). Not a new AI system and not machine-learning training. **Starts only after GB-04's plain version works.** I have not checked how much of Ask CE is built.

## 1. Tim's words
29 Oct 2026: "is there a way through the claude api that we can have machine learning be smart?" and "yes add its own card".

## 2. What Claude would do (always proposes, never decides)
1. **Read the drawing against the return list** (GB-04) for items that are text, such as notes and details.
2. **Read a council PDF and propose profile values** with the page and the quoted line; the engineer confirms each one; unconfirmed stays Assumed.
3. **Write the council enquiry email** with site and impervious areas filled in from the drawing.
4. **Explain a warning in plain words** and what to try.
5. **Find similar past jobs** from the anonymised evidence store and show how they were handled.

## 3. What it must never do
1. Calculate a flow, fall, cover, orifice or storage. Those stay Settings plus plain rules.
2. Change Settings or the drawing without Plan, Preview, explicit Apply and one Undo.
3. Fill a gap with a guess: Unknown stays Unknown.
4. Send client names, addresses or drawings off the PC. Confidential jobs get no access (AI-01).

## 4. Before any build
1. The 22 Oct privacy review found the AI connection could redirect drawing data and the access token; confirm it is fixed (not checked here).
2. Provider, model, who pays, usage cap, who gets it (Tim and staff roles as in AI-01). Keys only from `C:\Users\TimothyBrand\Keys\keys.txt`.
3. The assistant being down must leave drafting fully usable.

## 5. Slices
1. Council document reader (read-only, nothing written). 2. Explain-a-warning. 3. Enquiry email. 4. Text items for GB-04. 5. Similar past jobs.

## 6. Test
Guards: a document with a known value is read correctly with the right page; a wrong or missing value stays Unknown; no client text leaves the PC (check the outgoing text). Codex in AutoCAD for the windows.

## 7. Open points for Tim
1. Provider and model, and the monthly cost ceiling.
2. Whether colleagues get it on 9 Nov or later.

## 8. What already exists in the installed build (read from commit 09126560, 29 Oct 2026; not run)
1. A **Claude connection is already in the plugin** (`CE.AI.Core/AnthropicChatClient.cs`, address api.anthropic.com), with a conversation loop and AutoCAD tools (selection, pipe tidy-up). Per-person access comes through a "seat grant" service. So GB-05 builds on this; it is not a new system.
2. **The model names in the code are old** (haiku-4-5, sonnet-5, opus-4-8). The newest are Haiku 5.5, Sonnet 5.5, Opus 5.5 and Fable 5.1. The model list becomes a Settings value, never fixed in code (R-00).
3. **The 22 Oct privacy finding is not confirmed fixed.** `areas/CODEX_HUNT_PRIVACY_22OCT.md` H01: the sender can send the access token to an unapproved or unencrypted address. I found no record that it is fixed. GB-05 slice 1 does not start until it is confirmed fixed and Codex-checked.

## 9. Recommended answers for Tim's three open points (DRAFT until Tim says; his answer replaces them)
1. **Provider and model:** Claude through the existing connection. Model by job, per MODEL_ROUTING: Haiku for mechanical reading and drafting emails, Sonnet for reading council PDFs and explaining warnings, Opus only for hard checks. Names on Settings.
2. **Cost ceiling:** a monthly cap per person as a Settings value, **blank by default**, and blank means no Claude calls until a figure is set (Unknown stays Unknown). Tim names the figure.
3. **Who gets it:** Tim's PC only until the privacy finding is fixed and Codex has accepted slice 1; colleagues after that, not on 9 Nov.

## 10. Status
DRAFT. Not approved. Not built.
