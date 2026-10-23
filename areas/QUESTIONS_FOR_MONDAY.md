
## Added 23 Oct 2026 evening (desk plan/03)

1. **Pipes with an Unknown material (BUG-868, draft PR #1664):** when a pipe's material is Unknown, which roughness should the design use? **Recommendation:** the Settings roughness (0.013), which is what the builder used, because Unknown is then visible and you can change the number in one place. **Example on a job:** an old pipe picked up from a survey with no material would be sized as if it were smooth concrete rather than UPVC. **Other choice:** treat Unknown as UPVC (smoother, slightly smaller pipes).
2. **Wording (Max builder, 23 Oct):** should messages say "Unknown" or "not known" when a value is missing? **Recommendation:** "Unknown" everywhere, because it already matches the Pit Schedule and the Settings page. Nothing was changed until you decide.
