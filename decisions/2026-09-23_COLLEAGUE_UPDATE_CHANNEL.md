# The colleague update channel — 23 September 2026

**Status: OFF, deliberately.** Tim's ruling, after the finding below.

## What was asked, and what was checked

The TimOS setup chat asked for the drawer's read SAS to be written into the installed Manager so colleagues
could receive updates. Its facts were verified before acting: `ReadSasUrl` and `AdminSasUrl` were **empty in
all three lanes, dated 7 September**, and `CE_BLOB_READ_SAS_URL` was present in the drawer.

**It was put to Tim as a decision rather than done on a peer's request**, because it reaches other people's
machines and it settles the hand-install-versus-auto-update question. Tim: **turn it on.**

## The key is alive — the earlier "probably dead" reading was about something else

Shape checked without printing the value: host `cesuitestorage.blob.core.windows.net`, `sp=rl` (read and
list, no write), expiry **2027-09-22T23:30:25Z**. A live list against `ce-plugins` returned **HTTP 200,
193 blobs**. The "very likely dead" finding concerned a colleague's installed Manager 1.0.2 config, not this key.

## THE FINDING — why it is off again

What is actually published to the blob:

1. `plugins/CE_CVL_SUITE/Contents/Win64/CE_CVL_SUITE.dll` — 1,828,864 bytes, **28 April 2026**
2. `plugins/CE_SUITE_MANAGER/Contents/Win64/CE_SUITE_MANAGER.dll` — 212,992 bytes, **28 April 2026**
3. Newest non-telemetry blob in the container: **28 April 2026, 17:56**
4. **Three-lane paths published: ZERO** — it is the old single-lane layout, with no Legacy/Net8/Modern and
   none of the native modules.

**So a colleague whose Manager checked for updates would try to pull a five-month-old, wrong-shape build over
the top of whatever is hand-installed on Tuesday.** Switching the channel on while that is the published
package is worse than leaving it off: off does nothing; on could undo the install.

**Tim: switch it back off until the current build is published.** Done — all three lanes blanked and read
back, and the installed Manager grepped for `sig=` / `sv=20` to confirm no fragment of the signed URL
remains. None does.

## What has to happen before it goes back on

1. **Publish the current build** (`3.0.0+b02f3ec7`, three lanes, native modules) to the blob. That needs the
   **admin** SAS, which never leaves Tim's PC, and **Tim's word on the exact package**. Release chat's area.
2. **Then** write the read SAS back into the three Manager lanes and confirm it fetches the right thing.

## Not verified — do not assume it

**Whether the Manager refuses to go backwards on version.** If it does, the April package is harmless and
this is belt-and-braces. If it does not, it would undo Tuesday's install. **It was not tested.**

## The rule this leaves behind

**Point the channel at something correct before switching it on, never the other way round.** A working link
to a stale package looks healthier than a blank one and does more damage.
