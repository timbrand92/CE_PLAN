#!/usr/bin/env bash
# Desk 23 Oct 2026: honest Computer Use probe: asks a fresh codex exec session to list, through its exec (code mode) tool, every tool whose name mentions node_repl, sky, computer or screenshot; prints CU_OK if node_repl/sky appears, else CU_MISSING.
cd "C:/Lisp Files/_TEST_COPIES_20260923"
out=$(timeout 170 codex exec --skip-git-repo-check --dangerously-bypass-approvals-and-sandbox --ephemeral -m gpt-6.1-sol -c model_reasoning_effort=low -C "C:/Lisp Files/_TEST_COPIES_20260923" "Probe only. Call your exec tool once with the JavaScript: text(ALL_TOOLS.map(x=>x.name).filter(n=>/node_repl|sky|computer_use|windows_app|screen/i.test(n)).join(',') || 'NONE'). Reply with the word TOOLS then exactly what it returned. No screenshots." < /dev/null 2>/dev/null | tail -3 | tr '\n' ' ')
echo "$out"
if echo "$out" | grep -qi -E "node_repl|sky|computer"; then echo CU_OK; else echo CU_MISSING; fi
