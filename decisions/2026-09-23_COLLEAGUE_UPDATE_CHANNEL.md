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

---

## TWO BLOCKERS FOUND AFTERWARDS — both are Tim's, both need his Azure login

Added 23 September 2026, after Tim said *"publish the current build so the channel can go back on"*. **The
publish could not be done, and the reason is not policy — it is two dead keys.** Recorded here so nobody
rediscovers them.

### 1. The write key is rejected — the channel cannot be re-published by anyone

`AZURE_ADMIN_SAS` in the drawer returns **HTTP 403** against `ce-plugins`.

It looks valid on paper: rights `rwdl`, expiry `2028-07-20`. **The signature is refused.** That is the
**SEC-001** rotation of July 2026: both storage keys were regenerated, the **read** key was re-minted (it
works — HTTP 200, 193 blobs), and the **write** key never was. The follow-up said the new admin SAS should go
into `%APPDATA%\CE_SUITE\blob-config.local.json`. **That file does not exist**, nor either plausible variant.

**Consequence:** nobody can publish — not this chat, not the release chat, not the plugin's own
CEADMIN → "Publish to Azure" button, which uses the same credential. **Tim must re-mint the admin SAS in
Azure and put it in the local file.** Until then the April 2026 package stays published, which is safe only
because the channel is off.

### 2. The signing key does not match the one the plugin trusts

`C:\Users\TimothyBrand\Keys\CE Release\` holds a private/public pair dated 22 July 2026. Its **public half
does not match** `Installer/ReleaseAuthority/ce-release-public-key.pem`, which is embedded in the Manager and
is what `CeReleaseTrustStore.LoadEmbeddedPublicKeys` verifies against.

Fingerprints of the two public halves: drawer `edc55196…` · embedded `43c543bb…`. **Different keys.**
Confirmed independently by the TimOS chat using a different hash, same result.

**Consequence, and this is the bigger one:** a release signed with the drawer key **would be rejected by the
plugin itself**. `CeApprovedReleaseService.TryVerifyPinnedApproval` accepts only signed, pinned approvals
verified against the embedded key. **So the Version 3 update channel cannot be switched on by publishing OR
by signing until this is resolved** — either the matching private key is found, or a new pair is enrolled and
the public half is rebuilt into the plugin.

This blocker was hidden behind the publishing question and is the real reason Version 3 has no update channel.

### What this does NOT block

**Tuesday's hand install is unaffected.** It does not use the blob, the update channel or a signed approval.
Both items are for **after** Tuesday.
