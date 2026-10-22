#!/usr/bin/env bash
cd "C:/Lisp Files/_CODEX_RUNNER"
MAXC=12 bash queue3.sh "cx_s01|C:/Lisp Files/_CODEX_RUNNER|gpt-6-astra|high|98|6" "cx_s02|C:/Lisp Files/_CODEX_RUNNER|gpt-6-astra|high|98|6" "cx_s03|C:/Lisp Files/_CODEX_RUNNER|gpt-6-astra|high|98|6" "cx_s04|C:/Lisp Files/_CODEX_RUNNER|gpt-6-astra|high|98|6" >> "C:/CE_PLAN/desk_jobs/codex_lane17.out" 2>&1
