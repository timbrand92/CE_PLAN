# Log failure candidates

One line per new FAILED command run or new [ERR] message seen in the CE logs (written by log_outcomes.ps1). The desk reads this at each tick and files real product problems as bugs. This file never creates a BUG_CARPARK entry.

Format: date time | command | message (cut) | log file name | count

2026-10-18 11:42 | (no command marker) | Error disposing palette: Object reference not set to an instance of an object. | ce_struc_suite.log | 1
2026-10-18 17:30 | CDFIXTAGS | CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. | ce_cvl_structured_20261018.log | 3
2026-10-18 17:30 | CDFIXTAGS | CDFIXTAGS could not rename block 119FF8: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. | ce_cvl_structured_20261018.log | 1
2026-10-18 17:31 | CDTAG | CDTAG failed: InvalidOperationException: The requested source tag is not unique in the drawing. | ce_cvl_structured_20261018.log | 1
2026-10-19 12:48 | CDFIXTAGS | CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. | ce_cvl_structured_20261019.log | 3 (recurring, first seen 2026-10-18)
2026-10-19 12:48 | CDFIXTAGS | CDFIXTAGS could not rename block 119FF8: InvalidOperationException: The captured object has no unique matching drawing/project spine identity. | ce_cvl_structured_20261019.log | 1 (recurring, first seen 2026-10-18)
2026-10-19 15:24 | (no command marker) | Error disposing palette: Object reference not set to an instance of an object. | ce_struc_suite.log | 1 (recurring, first seen 2026-10-18)
2026-10-20 05:41 | CDFIXTAGS | CDFIXTAGS could not rename block 109474: InvalidOperationException: A source child does not have exactly one matching claim by the selected source. | ce_cvl_structured_20261020.log | 6 (recurring, first seen 2026-10-18)
