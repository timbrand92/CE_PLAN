# LISP Rebuild Prompt Template

Use this prompt when starting a new chat to rebuild AutoCAD LISP files.

---

## THE PROMPT (copy everything below the line)

---

I want to rebuild my AutoCAD LISP files from scratch with improvements. Follow this process:

## PHASE 1: ANALYSIS & DOCUMENTATION
First, read and analyze all my existing LISP files to understand:
- Every command and what it does
- Layer names, colors, and linetypes used
- Text heights and justifications
- Any memory/persistence systems
- UCS handling
- Error handling and layer restoration
- Block references and file paths
- Any interdependencies between files

Create a comprehensive report documenting ALL functionality before we change anything.

## PHASE 2: PLANNING
After the report, plan the new consolidated LISP system:
- Single file with no loading order dependencies
- Unified configuration table at top of file
- Generic reusable functions where possible
- Proper error handling with layer/UCS restoration
- Memory system for last-used values
- Keep ALL original layer names, colors, heights, and functionality EXACTLY the same
- Suggest improvements to architecture only (not functionality changes)

## PHASE 3: BUILD
Only after I approve the plan:
- Build the new LISP file section by section
- Verify parenthesis balance after each major section
- Test commands work identically to originals

## CRITICAL REQUIREMENTS:
- Layer names MUST remain exactly as they were
- All command names MUST remain the same
- All functionality MUST work identically to before
- UCS support must be preserved
- Layer must save before and restore after every command
- OSMODE must save before and restore after every command

## FILES TO ANALYZE:
- c:\Lisp Files\FILE1.lsp
- c:\Lisp Files\FILE2.lsp
- c:\Lisp Files\FILE3.lsp

Start with Phase 1 - read all files and create the functionality report.

---

## NOTES FOR USAGE

### Before Starting:
1. Update the FILES TO ANALYZE section with your actual file paths
2. Move old versions to `c:\Lisp Files\SUPERSEDED\` folder before rebuilding
3. Have AutoCAD open for testing

### During the Process:
- Ask for clarification on anything unclear
- Request to see the plan before building starts
- Verify parenthesis balance regularly (open = close)
- Test commands in AutoCAD after each major section

### Key Things to Verify:
- [ ] All commands work identically to before
- [ ] Layer names unchanged
- [ ] Colors unchanged
- [ ] Text heights unchanged
- [ ] UCS functionality works
- [ ] Layer saves/restores after each command
- [ ] OSMODE saves/restores after each command
- [ ] Memory systems work (last-used values remembered)
- [ ] Error handler restores settings if command cancelled

### Successful Rebuilds:
- [x] CE_SUPPORT_TEXT_INSERTION.lsp (2026-01-14) - Combined TEXT ANNOTATIONS + SUPPORT_COMPLETE
  - 57+ commands
  - Text annotations, rectangle+text, MLINE, support blocks
  - Location: `c:\Lisp Files\CE_SUPPORT_TEXT_INSERTION.lsp`

---

## ARCHITECTURE PATTERN USED

```
SECTION 1:  Configuration (constants, paths, settings table)
SECTION 2:  Global Variables (memory systems)
SECTION 3:  Error Handling (*error* function)
SECTION 4:  UCS Utilities (store/restore/check UCS)
SECTION 5:  Layer Management (set layer with create if needed)
SECTION 6:  Memory System (get/set last text, get/set sizes)
SECTION 7:  Core Functions (generic reusable functions)
SECTION 8+: Specialized Functions (grouped by feature)
SECTION N-1: Command Definitions (defun c:XXX calls to functions)
SECTION N:  Initialization (load message)
```

### Key Patterns:
- Every function saves layer/OSMODE at start, restores at end
- UCS check: `(ce-is-ucs-world)` returns T if World UCS
- UCS store/restore: `(ce-store-ucs)` and `(ce-restore-ucs ucs-data)`
- Point transformation: `(trans pt 1 0)` for UCS to World
- Layer set: `(ce-set-layer "LAYER NAME" "COLOR" "LINETYPE")`
