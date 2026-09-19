# CE_CVL_SUITE - COMPLETE SPECIFICATION DOCUMENT
## Civil Stormwater Drainage Suite - Full Implementation Plan

**Document Version:** 1.0
**Created:** 2026-01-15
**Last Updated:** 2026-01-15
**Status:** APPROVED FOR DEVELOPMENT

---

# EXECUTIVE SUMMARY

This document provides the complete specification for rebuilding the CDD (Civil Drainage Design) AutoCAD LISP system. The rebuild includes:

1. **Modern .NET WPF dialogs** replacing outdated DCL dialogs
2. **New PIT command** for placing stormwater pits with automatic schedule integration
3. **New PITSCHEDULE command** for spreadsheet-style schedule editing
4. **Bug fixes** for Quick Mode and Text Masking
5. **UCS support** for point transformation
6. **JSON settings system** replacing scattered environment variables

---

# TABLE OF CONTENTS

1. [Current System Overview](#1-current-system-overview)
2. [New System Architecture](#2-new-system-architecture)
3. [CDD Command - Complete Specification](#3-cdd-command---complete-specification)
4. [PIT Command - Complete Specification](#4-pit-command---complete-specification)
5. [PITSCHEDULE Command - Complete Specification](#5-pitschedule-command---complete-specification)
6. [Workflow: How It All Works Together](#6-workflow-how-it-all-works-together)
7. [Technical Implementation Details](#7-technical-implementation-details)
8. [Data Storage & Settings](#8-data-storage--settings)
9. [Known Issues & Fixes](#9-known-issues--fixes)
10. [Build Phases & Timeline](#10-build-phases--timeline)
11. [Testing Requirements](#11-testing-requirements)
12. [Appendices](#12-appendices)

---

# 1. CURRENT SYSTEM OVERVIEW

## 1.1 Original Files

| File | Size | Description |
|------|------|-------------|
| `CDD COMMAND.lsp` | 490KB (~10,000 lines) | Main LISP file with all CDD functionality |
| `CDD_DCL.dcl` | 558 lines | Dialog Control Language definitions |

## 1.2 Current Commands

| Command | Alias | Description |
|---------|-------|-------------|
| `CDD` | - | Main civil drainage design command |
| `CDD-SETTINGS` | `CDDS` | Advanced settings dialog (includes text offset) |
| `CDD-OSNAP` | - | Configure OSNAP settings for drawing/text phases |
| `CDD-MOVE-ARROW` | `CDDA`, `MFA` | Move flow arrow to different pipe segment |

## 1.3 Current Layer Structure

| Layer Name | Color | Linetype | Purpose |
|------------|-------|----------|---------|
| `STORMWATER PIPE` | 150 | DASHED | Standard stormwater pipe polyline |
| `STORMWATER UPVC CHARGED PIPE` | 10 | DASHED | Charged pipe polyline |
| `STORMWATER SUSPENDED PIPE` | 211 | DASHED | Suspended pipe polyline |
| `STORMWATER RISING MAIN` | 70 | DASHED | Rising main polyline |
| `DRAINAGE` | 6 | CONTINUOUS | MLINE for most pipe types |
| `DRAINAGE HIDDEN` | 6 | HIDDEN | MLINE for suspended pipes |
| `25TEXT` | 7 (White) | CONTINUOUS | Pipe text labels |
| `20TEXT` | 10 | CONTINUOUS | Invert text labels |
| `ARROW` | 7 (White) | CONTINUOUS | Flow arrows |

## 1.4 Current Text Settings

| Setting | Value | Purpose |
|---------|-------|---------|
| `*CDD-TEXT-HEIGHT*` | 250 | Pipe label text height |
| `*CDD-TEXT-LINE-SPACING*` | 0.8 | Line spacing factor |
| `*CDD-TEXT-BACKGROUND-SCALE*` | 1.2 | Background mask scale |
| `*CDD-TEXT-DEFAULT-OFFSET*` | 70 | Text offset from pipe |
| `*CDD-INVERT-TEXT-HEIGHT*` | 180 | Invert level text height |
| `*CDD-INVERT-INWARD-DISTANCE*` | 100 | Masked invert offset from endpoint |

## 1.5 Known Issues to Fix

| # | Issue | Description |
|---|-------|-------------|
| 1 | No UCS Support | Points not transformed to World coordinates |
| 2 | Hardcoded Path | DCL path hardcoded as `C:/Lisp Files/CDD_DCL.dcl` |
| 3 | Duplicate Code | Main command `c:CDD` defined twice (lines 5001 and 10646) |
| 4 | Quick Mode Bug | Invert positions not working correctly in certain directions |
| 5 | Text Masking Bug | Regular TEXT vs masked MTEXT have different justification logic |
| 6 | Large File | 490KB single file is difficult to maintain |

---

# 2. NEW SYSTEM ARCHITECTURE

## 2.1 Technology Stack

| Component | Technology |
|-----------|------------|
| AutoCAD Integration | AutoLISP |
| Dialogs | C# WPF (.NET Framework 4.7.2+) |
| LISP ↔ .NET Communication | COM Object Interface |
| Settings Storage | JSON files |
| Target AutoCAD Version | 2022+ (multi-version compatible) |

## 2.2 New File Structure

```
C:\TIMCADTOOLS\
├── CDD_Core.lsp              ← Main LISP file (consolidated, cleaner)
├── CDD_Dialog.dll            ← .NET WPF dialog for CDD command
├── PIT_Dialog.dll            ← .NET WPF dialog for PIT command
├── Schedule_Editor.dll       ← .NET spreadsheet editor for PITSCHEDULE
├── CDD_DCL.dcl               ← DCL fallback (if .NET fails to load)
└── Blocks\
    └── TIM_CVL_ARROW.dwg     ← Arrow block

%APPDATA%\TIMCADTOOLS\
├── CDD_Settings.json         ← User settings (persistent across sessions)
└── CDD_ProjectData.json      ← Current drawing's pipe/pit data
```

## 2.3 New Commands

| Command | Alias | Description | Status |
|---------|-------|-------------|--------|
| `CDD` | - | Main drainage pipe drawing command | REBUILD |
| `CDD-SETTINGS` | `CDDS` | Advanced settings dialog | REBUILD |
| `CDD-MOVE-ARROW` | `CDDA`, `MFA` | Move arrow to different segment | KEEP |
| `SETOFFSET` | - | Set text offset distance | **REMOVE** - Moved to CDD-SETTINGS |
| `PIT` | - | Place pit with details dialog | **NEW** |
| `PITSCHEDULE` | - | Schedule editor spreadsheet | **NEW** |

## 2.4 LISP ↔ .NET Communication

The system uses COM Object interface for communication between LISP and .NET:

```lisp
;; Step 1: Load the .NET DLL (once when AutoCAD starts)
(command "NETLOAD" "C:/TIMCADTOOLS/CDD_Dialog.dll")

;; Step 2: Create a connection to the .NET dialog service
(setq dialog-service (vlax-create-object "CDD.DialogService"))

;; Step 3: Show dialog and get result back as delimited string
(setq result (vlax-invoke dialog-service 'ShowMainDialog))

;; Step 4: Result format:
;; "diameter=100|material=UPVC|pipetype=1|grade=100|..."

;; Step 5: Parse result and use values
(setq diameter (cdd-get-result-value result "diameter"))

;; Step 6: Clean up COM object
(vlax-release-object dialog-service)
```

---

# 3. CDD COMMAND - COMPLETE SPECIFICATION

## 3.1 Purpose

The CDD command draws civil drainage pipes with:
- Polyline representation on appropriate layer
- MLINE representation for visual thickness
- Pipe label text (diameter, material, grade)
- Invert level text at endpoints
- Flow direction arrow

## 3.2 Dialog Design (All Sections Visible - No Tabs)

```
┌────────────────────────────────────────────────────────────────────────────────┐
│  CDD v4.0 - Civil Drainage Design                    [Light/Dark]   [─][□][×]  │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  ┌─ PIPE PROPERTIES ─────────────────────┐  ┌─ PIPE TYPE ────────────────────┐│
│  │                                        │  │                                ││
│  │  Diameter: [ 100         ▼]  mm       │  │  ◉ Stormwater Pipe             ││
│  │            (searchable dropdown)       │  │  ○ Charged Pipe     → [ WT   ] ││
│  │                                        │  │  ○ Suspended Pipe              ││
│  │  Material: [ UPVC        ▼]           │  │  ○ Rising Main      → [ PIT  ] ││
│  │            (searchable dropdown)       │  │  ○ Detention Pipe              ││
│  │                                        │  │                                ││
│  │  ☐ Simple Pipe Only (no text/inverts) │  └────────────────────────────────┘│
│  └────────────────────────────────────────┘                                    │
│                                                                                │
│  ┌─ GRADE ───────────────────────────────┐  ┌─ INVERTS ─────────────────────┐ │
│  │                                        │  │                                ││
│  │  ◉ Default (1 in 100 MIN.)            │  │  ☑ First Point:  [ 1.10    ]  ││
│  │  ○ Calculate from Inverts             │  │  ☑ Second Point: [ 1.20    ]  ││
│  │  ○ Custom: [ 1 in _____ ]             │  │                                ││
│  │                                        │  │  ☐ Mask invert text (MTEXT)   ││
│  └────────────────────────────────────────┘  │                                ││
│                                              │  Recent: 1.10 | 1.05 | 0.95   ││
│                                              └────────────────────────────────┘│
│                                                                                │
│  ┌─ TEXT & ARROW ────────────────────────┐  ┌─ QUICK MODE ──────────────────┐ │
│  │                                        │  │                                ││
│  │  ☑ Create Pipe Text                   │  │  ☐ Auto-place ALL (fastest)   ││
│  │  ☑ Insert Flow Arrow                  │  │  ☐ Auto-place Pipe Text only  ││
│  │  ☐ Reverse Arrow Direction            │  │  ☐ Auto-place Inverts only    ││
│  │                                        │  │  ☑ Auto-zoom to Pipe          ││
│  └────────────────────────────────────────┘  └────────────────────────────────┘│
│                                                                                │
│  ┌─ SCHEDULE & BATCH ─────────────────────────────────────────────────────────┐│
│  │  ☑ Include in Pit Schedule (track this pipe for schedule)                 ││
│  │  ☐ Enable Batch Mode (draw multiple pipes with same settings)             ││
│  └───────────────────────────────────────────────────────────────────────────┘│
│                                                                                │
│  ┌─ ARROW DIRECTION PREVIEW ───────────────────────────────────────────────┐  │
│  │                                                                          │  │
│  │       1.10m ══════════════════►══════════════════ 1.05m                 │  │
│  │                                                                          │  │
│  │       ✓ Flow: Left → Right (First Point higher)                         │  │
│  │       ✓ Grade: 1 in 200 (will be calculated from inverts)               │  │
│  └──────────────────────────────────────────────────────────────────────────┘  │
│                                                                                │
├────────────────────────────────────────────────────────────────────────────────┤
│   [ ⚙ Settings ]                    [ OK ]    [ Cancel ]    [ Reset ]         │
└────────────────────────────────────────────────────────────────────────────────┘
```

## 3.3 Searchable Dropdown Behavior

```
┌─ Diameter ──────────────────┐
│ [ 15                     ▼] │  ← User types "15"
├─────────────────────────────┤
│ ► 150                       │  ← Filtered to show matches
│   Custom...                 │
└─────────────────────────────┘
```

**Behavior:**
- Click dropdown OR just start typing to filter
- List filters as you type (partial match)
- Arrow keys to navigate filtered list
- Enter to select highlighted option
- If no match found, shows "Custom..." option
- Selecting "Custom..." opens input dialog for arbitrary value

## 3.4 Pipe Diameter Options

| Value | Description |
|-------|-------------|
| 100 | 100mm diameter |
| 150 | 150mm diameter |
| 225 | 225mm diameter |
| 300 | 300mm diameter |
| 450 | 450mm diameter |
| Custom... | Opens input dialog |

## 3.5 Pipe Material Options

| Value | Description |
|-------|-------------|
| UPVC | Standard UPVC pipe |
| RCP / RRJ | Reinforced Concrete Pipe / Rubber Ring Joint |
| UPVC SEWER CLASS | Heavy-duty UPVC |
| RCP | Reinforced Concrete Pipe |
| STORMPRO | StormPro brand pipe |
| Custom... | Opens input dialog |

## 3.6 Pipe Types and Layers

| Pipe Type | Polyline Layer | Color | MLINE Layer | Destination |
|-----------|---------------|-------|-------------|-------------|
| Stormwater Pipe | STORMWATER PIPE | 150 | DRAINAGE | None |
| Charged Pipe | STORMWATER UPVC CHARGED PIPE | 10 | DRAINAGE | WT (typical) |
| Suspended Pipe | STORMWATER SUSPENDED PIPE | 211 | DRAINAGE HIDDEN | None |
| Rising Main | STORMWATER RISING MAIN | 70 | DRAINAGE | PIT (typical) |
| Detention Pipe | STORMWATER PIPE | 150 | DRAINAGE | None |

**Note:** "Destination" field appears next to Charged Pipe and Rising Main radio buttons. User can type the destination (e.g., "WT" for water tank, "PIT" for pit).

## 3.7 Grade Options

| Option | Behavior |
|--------|----------|
| Default (1 in 100 MIN.) | Uses "1 in 100 MIN." as grade text |
| Calculate from Inverts | Calculates actual grade from invert difference and pipe length |
| Custom | User enters custom grade value (e.g., "150" for 1 in 150) |

**Grade Calculation Formula:**
```
Grade = Distance / (FirstInvert - SecondInvert)
Display as: "1 in [Grade]"
```

## 3.8 Invert Options

| Checkbox | Description |
|----------|-------------|
| First Point | Show invert level at first clicked point |
| Second Point | Show invert level at second clicked point |
| Mask invert text | Use MTEXT with background mask instead of regular TEXT |

**Recent Values:** Shows last 5 unique invert values. Click to populate field.

## 3.9 Quick Mode Options

| Option | Behavior |
|--------|----------|
| Auto-place ALL | No prompts - automatically positions pipe text, arrow, and inverts |
| Auto-place Pipe Text only | Auto-positions pipe text; prompts for invert positions |
| Auto-place Inverts only | Prompts for pipe text position; auto-positions inverts |
| Auto-zoom to Pipe | Zooms to show the completed pipe after drawing |

## 3.10 Schedule Integration Toggle

**"Include in Pit Schedule"** checkbox:
- When checked: Pipe data is tracked for the pit schedule system
- When unchecked: Pipe is drawn but NOT tracked (e.g., minor drainage that doesn't need scheduling)
- Default: Checked

## 3.11 Batch Mode

When enabled:
- After completing first pipe, prompts: "Draw another pipe with same settings? [Yes/No]"
- Yes = Repeat point collection with same settings
- No = Exit command

## 3.12 CDD Command Workflow

```
1. User types CDD
2. .NET dialog appears (or DCL fallback if .NET fails)
3. User configures options and clicks OK
4. Dialog closes, values passed to LISP
5. User picks first point (OSNAP mode for drawing)
6. User picks additional points (multi-segment pipe supported)
7. User presses Enter to finish point collection
8. System draws:
   a. Polyline on appropriate pipe layer
   b. MLINE on DRAINAGE layer
   c. Flow arrow (if enabled)
   d. Pipe text (if enabled, or prompts for position)
   e. Invert text at endpoints (if enabled, or prompts for positions)
9. System zooms to pipe (if enabled)
10. If Batch Mode: prompts for another pipe
11. Command ends
```

---

# 4. PIT COMMAND - COMPLETE SPECIFICATION

## 4.1 Purpose

The PIT command places stormwater pits in the drawing with:
- Pit block (dynamic block with visibility states)
- Pit label block with attribute
- Cover level MTEXT with background mask
- Automatic tracking for schedule system

## 4.2 Key Workflow Concept

**IMPORTANT: PITS ARE PLACED FIRST, THEN PIPES CONNECT BETWEEN THEM**

This is the opposite of what might be assumed. The workflow is:
1. User places all pits using PIT command
2. User draws pipes using CDD command to connect the pits
3. User reviews/edits schedule using PITSCHEDULE command

## 4.3 Block Files

| Block | File Path | Purpose |
|-------|-----------|---------|
| Pit Block | `C:\Lisp Files\PIT BLOCK.dwg` | Dynamic block with visibility states for pit types |
| Pit Label | `C:\Lisp Files\PIT LABEL.dwg` | Block with 'FB' attribute for pit number |

## 4.4 Pit Block - Dynamic Properties

The pit block has a `PIT_TYPE` visibility parameter with 5 states:

| PIT_TYPE | Custom Properties | Description |
|----------|-------------------|-------------|
| GRATED PIT | X_WIDTH, Y_WIDTH | Standard grated pit |
| SOLID PIT | X_WIDTH, Y_WIDTH | Solid cover pit |
| SPS GRATED PIT | X_WIDTH, Y_WIDTH, SPS_RADIUS | Pump station with grate |
| SPS SOLID PIT | SPS_RADIUS | Pump station with solid cover |
| DETENTION PIT | X_WIDTH_DETENTION_SOLID, X_WIDTH_DETENTION_GRATED, Y_WIDTH_DETENTION | Combined grated/solid detention pit |

## 4.5 Pit Geometry Layers

```
PIT GEOMETRY (Cross-section view from top):

┌─────────────────────────────────────────────────────────────┐ ◄── Layer 3: +200 units from center
│                                                             │     (IMAGINARY - for MTEXT insertion points)
│    ┌───────────────────────────────────────────────────┐    │
│    │                                                   │    │ ◄── Layer 2: +100 units from center
│    │                                                   │    │     (PIT WALLS - drawn in block)
│    │         ┌───────────────────────────────┐         │    │
│    │         │                               │         │    │ ◄── Layer 1: Pit Size
│    │         │      PIT (e.g., 450x450)      │         │    │     (e.g., 450 x 450)
│    │         │                               │         │    │
│    │         └───────────────────────────────┘         │    │
│    │                                                   │    │
│    └───────────────────────────────────────────────────┘    │
│                                                             │
└─────────────────────────────────────────────────────────────┘

For a 450x450 pit:
- Layer 1 (pit opening): 450 x 450
- Layer 2 (pit walls): 450 + 100 + 100 = 650 x 650 (100 units offset each side)
- Layer 3 (imaginary): 650 + 100 + 100 = 850 x 850 (another 100 units offset)
```

## 4.6 Cover Level MTEXT Insertion

The MTEXT is inserted at the CORNER of the imaginary Layer 3 (200 units offset from pit edge).

```
MTEXT INSERTION POINTS (4 corners):

■ TOP LEFT (NW)                                              TOP RIGHT (NE) ■
  Rotation: 315°                                              Rotation: 45°
  Justify: Middle Right                                       Justify: Middle Left

                    ┌─────────────────────┐
                    │                     │
                    │     PIT BLOCK       │
                    │      (center)       │
                    │                     │
                    └─────────────────────┘

■ BOTTOM LEFT (SW)                                        BOTTOM RIGHT (SE) ■
  Rotation: 45°                                               Rotation: 315°
  Justify: Middle Right                                       Justify: Middle Left
```

**Calculation for insertion point (example: 450x450 pit, TOP RIGHT):**
```
X = pit_center_X + (pit_width/2) + 100 + 100 = center_X + 425
Y = pit_center_Y + (pit_height/2) + 100 + 100 = center_Y + 425
```

## 4.7 Cover Level MTEXT Properties

| Property | Value |
|----------|-------|
| Background Mask | ON |
| Line Spacing | 0.8x |
| Text Style | STANDARD |
| Layer | (inherit from drawing settings) |

**Rotation by position:**
| Position | Rotation Angle |
|----------|---------------|
| Top Left (NW) | 315° |
| Top Right (NE) | 45° |
| Bottom Left (SW) | 45° |
| Bottom Right (SE) | 315° |

**Justification by position:**
| Position | Justification |
|----------|--------------|
| Left-side (NW, SW) | Middle Right |
| Right-side (NE, SE) | Middle Left |

## 4.8 Cover Level MTEXT Content

**Regular Pit:**
```
CL 13.75
```
Or with optional lines above/below:
```
SILT PIT
CL 13.75
IL 13.45
```

**Plastic Pit (PP):**
```
PP
CL 13.75
```

The user can add additional text lines ABOVE and/or BELOW the CL line as needed.

## 4.9 Pit Invert Level

When enabled, the IL is placed as an additional line BELOW the CL in the same MTEXT:
```
CL 13.75
IL 13.45
```

## 4.10 Pit Label Block

- Block file: `C:\Lisp Files\PIT LABEL.dwg`
- Has single attribute: `'FB'`
- Attribute value: Pit number (e.g., "P1", "P2", "P3")
- Position: User selects (similar to L/R selection in DS1/TS1 commands)
- **NOT inserted for Plastic Pits (PP)**

## 4.11 Dialog Design

```
┌────────────────────────────────────────────────────────────────────────────────┐
│  Place Stormwater Pit                              [Light/Dark]     [─][□][×]  │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  ┌─ PIT DETAILS ──────────────────────────────────────────────────────────┐   │
│  │                                                                         │   │
│  │  Pit Number:    [ P1        ]  [Auto ▼]                                │   │
│  │                                                                         │   │
│  │  Pit Type:      [ GRATED PIT                            ▼]             │   │
│  │                 (GRATED PIT, SOLID PIT, SPS GRATED, SPS SOLID,         │   │
│  │                  DETENTION PIT)                                         │   │
│  │                                                                         │   │
│  │  X Width:       [ 450       ]  mm                                      │   │
│  │  Y Width:       [ 450       ]  mm                                      │   │
│  │  SPS Radius:    [ 900       ]  mm  (only for SPS types)                │   │
│  │                                                                         │   │
│  │  Cover Level:   [ 13.75     ]  m AHD                                   │   │
│  │                                                                         │   │
│  │  Text Above CL: [                                           ]          │   │
│  │  Text Below CL: [                                           ]          │   │
│  │                                                                         │   │
│  │  Lid Type:      [ Class A Grate                             ▼]         │   │
│  │                                                                         │   │
│  │  Remarks:       [ Silt Pit                                      ]      │   │
│  │                                                                         │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                │
│  ┌─ OPTIONS ──────────────────────────────────────────────────────────────┐   │
│  │                                                                         │   │
│  │  ☑ Add pit label block                                                 │   │
│  │  ☑ Add cover level text                                                │   │
│  │  ☑ Include in schedule                                                 │   │
│  │  ☐ Plastic pit (PP) - NO label block, NOT in schedule                  │   │
│  │                                                                         │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                │
│  ┌─ INVERT LEVEL (Optional) ──────────────────────────────────────────────┐   │
│  │                                                                         │   │
│  │  ☐ Show pit invert level:  [ 13.45     ]  m AHD                        │   │
│  │                                                                         │   │
│  │  (Added below CL in cover level text)                                  │   │
│  │                                                                         │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                │
│  ┌─ TEXT POSITION PREVIEW ────────────────────────────────────────────────┐   │
│  │                                                                         │   │
│  │           ○ TL                              TR ○                        │   │
│  │                    ┌─────────────┐                                      │   │
│  │                    │             │                                      │   │
│  │                    │     PIT     │                                      │   │
│  │                    │             │                                      │   │
│  │                    └─────────────┘                                      │   │
│  │           ○ BL                              BR ◉ (selected)             │   │
│  │                                                                         │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                │
├────────────────────────────────────────────────────────────────────────────────┤
│                      [ Place Pit ]              [ Cancel ]                     │
└────────────────────────────────────────────────────────────────────────────────┘
```

## 4.12 Pit Number Auto-Increment

The "Auto" dropdown next to Pit Number:
- **Auto:** Automatically increments (P1, P2, P3, P4...)
- **Manual:** User types specific number

System scans drawing for existing pit label blocks and suggests next available number.

## 4.13 Lid Type Options

| Type | Description |
|------|-------------|
| Class A Grate | Heavy duty (driveways, roads) |
| Class B Grate | Medium duty |
| Class C Grate | Light duty (gardens) |
| Class D Cover | Solid cover |
| Trafficable Cover | Can be driven over |
| Custom... | User-defined |

## 4.14 Plastic Pit Toggle

**"Plastic pit (PP) - NO label block, NOT in schedule"**
- When checked:
  - Pit block IS inserted (with sizing)
  - Pit label block is NOT inserted
  - Cover level MTEXT shows "PP" on line 1, "CL xx.xx" on line 2
  - Pit is NOT added to the schedule

## 4.15 PIT Command Workflow

```
1. User types PIT
2. .NET dialog appears
3. User enters pit details:
   - Pit number (or Auto)
   - Pit type (GRATED, SOLID, SPS GRATED, SPS SOLID, DETENTION)
   - Dimensions (X_WIDTH, Y_WIDTH, SPS_RADIUS as applicable)
   - Cover level
   - Optional text above/below CL
   - Lid type
   - Remarks
4. User selects text position (TL, TR, BL, BR) via preview
5. User selects options (label, cover text, include in schedule, plastic pit)
6. User clicks "Place Pit"
7. Dialog closes
8. User picks insertion point in drawing (pit center)
9. System inserts:
   a. Pit block at insertion point with correct visibility state and properties
   b. Pit label block (if not plastic pit) - user prompted for L/R position
   c. Cover level MTEXT at calculated corner position
10. System saves pit data to CDD_ProjectData.json
11. Command ends
```

## 4.16 Detection Radius

When CDD command draws pipes, endpoints within **100 units** of a pit center are automatically linked to that pit for schedule purposes

---

# 5. PITSCHEDULE COMMAND - COMPLETE SPECIFICATION

## 5.1 Purpose

The PITSCHEDULE command opens a spreadsheet-style editor showing all tracked pits and their connected pipes, allowing editing and placement into a schedule block in the drawing.

## 5.2 Dialog Design

```
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│  Stormwater Pit Schedule Editor                                                       [─][□][×]      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│  [ + Add Row ]  [ − Delete ]  [ ↑ Up ]  [ ↓ Down ]  [ Refresh from Drawing ]  [ Import CSV ]        │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                      │
│  ┌──────┬────────────────────┬────────────────────────────────┬────────────────────────────┬───────┐ │
│  │      │                    │           INLET                │          OUTLET            │       │ │
│  │ PIT  │      PIT SIZE      ├────────┬──────┬────────────────┼──────┬────────────┬────────┤ DEPTH │ │
│  │ No.  │                    │  FROM  │ DIA  │  INVERT LEVEL  │ DIA  │ INVERT LVL │ COVER  │       │ │
│  ├──────┼────────────────────┼────────┼──────┼────────────────┼──────┼────────────┼────────┼───────┤ │
│  │ P1   │ 450x450 Grated     │ DP     │ 100  │     13.70      │ 100  │   13.60    │ 13.75  │ 0.15  │ │
│  │ P1   │ 450x450 Grated     │ WT     │ 100  │     13.68      │ 100  │   13.60    │ 13.75  │ 0.15  │ │
│  │ P2   │ 450x450 Grated     │ DP     │ 100  │     13.65      │ 150  │   13.55    │ 13.70  │ 0.15  │ │
│  │ P3   │ 600x600 Junction   │ P1     │ 100  │     13.60      │ 150  │   13.50    │ 13.65  │ 0.15  │ │
│  │ P3   │ 600x600 Junction   │ P2     │ 150  │     13.55      │ 150  │   13.50    │ 13.65  │ 0.15  │ │
│  │ P4   │ 600x600 Junction   │ P3     │ 150  │     13.50      │ 225  │   13.40    │ 13.55  │ 0.15  │ │
│  └──────┴────────────────────┴────────┴──────┴────────────────┴──────┴────────────┴────────┴───────┘ │
│                                                                                                      │
│  ← Horizontal scroll for: LID TYPE, REMARKS →                                                        │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│  ☑ Auto-calculate DEPTH from Cover - Outlet IL                                                      │
│  ☑ Highlight warnings (depth < 0.30m shown in yellow)                                               │
│                                                                                                      │
│  Schedule Block: [ Select in Drawing... ]    Currently: (not selected)                               │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│       [ Place in Schedule Block ]        [ Export CSV ]        [ Close ]                             │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

## 5.3 Schedule Columns

| Column | Description | Source |
|--------|-------------|--------|
| PIT No. | Pit identifier (P1, P2, P3...) | From PIT command |
| PIT SIZE | Pit dimensions | From PIT command |
| FROM (Inlet) | Where inlet pipe comes from | Auto-detected or manual |
| DIA (Inlet) | Inlet pipe diameter | From CDD command |
| INVERT LEVEL (Inlet) | Inlet pipe invert at pit | From CDD command |
| DIA (Outlet) | Outlet pipe diameter | From CDD command |
| INVERT LEVEL (Outlet) | Outlet pipe invert at pit | From CDD command |
| COVER | Cover level at pit | From PIT command |
| DEPTH | Depth to outlet | Auto-calculated |
| LID TYPE | Type of lid/grate | From PIT command |
| REMARKS | Additional notes | Manual entry |

## 5.4 Multiple Rows Per Pit

**IMPORTANT:** A single pit can have MULTIPLE inlet pipes. Each inlet creates a SEPARATE ROW in the schedule.

Example:
```
Pit P3 receives pipes from both P1 and P2:
- Row 1: P3 | 600x600 Junction | P1 | 100 | 13.60 | 150 | 13.50 | 13.65 | 0.15
- Row 2: P3 | 600x600 Junction | P2 | 150 | 13.55 | 150 | 13.50 | 13.65 | 0.15
```

The PIT SIZE, OUTLET details, COVER, DEPTH, LID TYPE, and REMARKS are the same for both rows (since they're the same pit), but the INLET details differ.

## 5.5 FROM Field Values

The FROM column can contain:
| Value | Meaning |
|-------|---------|
| DP | Downpipe (from roof drainage) |
| WT | Water Tank connection |
| SPS | Stormwater Pump Station |
| P1, P2, P3... | Another pit |
| Custom | Any user-entered value |

## 5.6 Auto-Detection Logic

When pipes are drawn with CDD (with "Include in Pit Schedule" checked):
- System detects pipe endpoints
- If endpoint is within **100 units** of a pit center → links to that pit
- **DP/WT Detection:** Manual input only (dynamic downpipes and water tanks are complex)
- If no pit match found → user manually enters FROM value in schedule editor

**Note:** DP (downpipe) and WT (water tank) symbols are too varied to auto-detect reliably. These values should be entered manually in the PITSCHEDULE editor.

## 5.7 Depth Calculation

```
DEPTH = COVER LEVEL - OUTLET INVERT LEVEL
```

Example: Cover 13.75 - Outlet IL 13.60 = 0.15m depth

**Warning:** If depth < 0.30m, row is highlighted yellow (shallow pit warning).

## 5.8 Toolbar Buttons

| Button | Action |
|--------|--------|
| + Add Row | Add new blank row |
| − Delete | Delete selected row(s) |
| ↑ Up | Move selected row up |
| ↓ Down | Move selected row down |
| Refresh from Drawing | Re-scan drawing for pits and pipes, update table |
| Import CSV | Import schedule data from CSV file |

## 5.9 Schedule Block Details

**Block File:** `C:\Lisp Files\Pit Schedule.dwg`

**Insertion Point Offset:**
- Schedule block insertion point: (0, 0, 0)
- EXCEL IMPORTER text start point: (100, -2450) from block insertion

When user clicks "Place in Schedule Block":
1. User selects the schedule block insertion point in drawing
2. System calculates text positions using offset (100, -2450) from that point
3. System inserts MTEXT at each cell position using CIVIL EXCEL IMPORTER logic
4. Each row of schedule data populates the corresponding row in the table

**Future Enhancement:** Auto-import the schedule block template if not present in drawing.

## 5.10 Export CSV

Exports all schedule data to CSV file for use in Excel or other applications.

## 5.11 Compare with Engineer's XLSX

Future feature: Compare pit schedule with engineer's exported XLSX file to identify discrepancies.

---

# 6. WORKFLOW: HOW IT ALL WORKS TOGETHER

## 6.1 Complete Workflow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        STORMWATER DRAINAGE WORKFLOW                             │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  STEP 1: PLACE PITS                                                            │
│  ─────────────────                                                             │
│                                                                                 │
│  User runs PIT command for each pit location:                                  │
│                                                                                 │
│    PIT → Dialog → Enter: P1, 450x450 Grated, CL 13.75 → Place → Pick point    │
│    PIT → Dialog → Enter: P2, 450x450 Grated, CL 13.70 → Place → Pick point    │
│    PIT → Dialog → Enter: P3, 600x600 Junction, CL 13.65 → Place → Pick point  │
│                                                                                 │
│  Result: Drawing has pit blocks with labels and cover levels                   │
│          CDD_ProjectData.json has pit records                                  │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  STEP 2: DRAW PIPES                                                            │
│  ────────────────                                                              │
│                                                                                 │
│  User runs CDD command to connect pits:                                        │
│                                                                                 │
│    CDD → Dialog → 100 UPVC, IL 13.70→13.60 → OK → Pick DP → Pick P1           │
│    CDD → Dialog → 100 UPVC, IL 13.68→13.60 → OK → Pick WT → Pick P1           │
│    CDD → Dialog → 100 UPVC, IL 13.65→13.55 → OK → Pick DP → Pick P2           │
│    CDD → Dialog → 100 UPVC, IL 13.60→13.50 → OK → Pick P1 → Pick P3           │
│    CDD → Dialog → 150 UPVC, IL 13.55→13.50 → OK → Pick P2 → Pick P3           │
│    CDD → Dialog → 150 UPVC, IL 13.50→13.40 → OK → Pick P3 → Pick P4           │
│                                                                                 │
│  Result: Drawing has pipes connecting pits with text and arrows                │
│          CDD_ProjectData.json has pipe records with FROM/TO                    │
│                                                                                 │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  STEP 3: REVIEW & EDIT SCHEDULE                                                │
│  ─────────────────────────────                                                 │
│                                                                                 │
│  User runs PITSCHEDULE command:                                                │
│                                                                                 │
│    PITSCHEDULE → Spreadsheet editor opens                                      │
│                → Shows all pits and pipe connections                           │
│                → User can edit values, add/delete rows                         │
│                → User selects schedule block in drawing                        │
│                → Click "Place in Schedule Block"                               │
│                → Text placed into schedule                                     │
│                                                                                 │
│  Result: Schedule table in drawing is populated                                │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## 6.2 Data Flow Diagram

```
┌──────────────┐     ┌──────────────────────┐     ┌──────────────────┐
│ PIT Command  │────►│ CDD_ProjectData.json │◄────│ CDD Command      │
└──────────────┘     │                      │     └──────────────────┘
                     │  {                   │
                     │    "pits": [         │
                     │      { P1 data },    │
                     │      { P2 data }     │
                     │    ],                │
                     │    "pipes": [        │
                     │      { pipe data },  │
                     │      { pipe data }   │
                     │    ]                 │
                     │  }                   │
                     │                      │
                     └──────────┬───────────┘
                                │
                                ▼
                     ┌──────────────────────┐
                     │ PITSCHEDULE Command  │
                     │                      │
                     │ Reads JSON, displays │
                     │ in spreadsheet,      │
                     │ places in drawing    │
                     └──────────────────────┘
```

---

# 7. TECHNICAL IMPLEMENTATION DETAILS

## 7.1 LISP Module Structure

```lisp
;;; =====================================================================
;;; CDD_Core.lsp - Civil Drainage Design v4.0
;;; =====================================================================

;;; SECTION 1: CONFIGURATION
;;; - Base path detection (dynamic, not hardcoded)
;;; - Layer definitions table
;;; - Text settings table
;;; - Block names

;;; SECTION 2: GLOBAL VARIABLES
;;; - Runtime state variables
;;; - Dialog result storage

;;; SECTION 3: ERROR HANDLING
;;; - *error* function with full restore
;;; - cdd-cleanup function

;;; SECTION 4: UCS UTILITIES (NEW)
;;; - cdd-is-ucs-world: Check if current UCS is World
;;; - cdd-store-ucs: Save current UCS
;;; - cdd-restore-ucs: Restore saved UCS
;;; - cdd-transform-point: Transform point from UCS to World
;;;   Usage: (setq world-pt (trans ucs-pt 1 0))

;;; SECTION 5: LAYER MANAGEMENT
;;; - cdd-set-layer: Create layer if needed, set current
;;; - cdd-get-pipe-layer-props: Get layer properties for pipe type
;;; - cdd-bring-layers-to-front: DRAWORDER management

;;; SECTION 6: SETTINGS MANAGEMENT
;;; - cdd-load-settings: Load from JSON file
;;; - cdd-save-settings: Save to JSON file
;;; - cdd-get-setting / cdd-set-setting: Get/set individual values

;;; SECTION 7: .NET DIALOG INTERFACE
;;; - cdd-show-dialog: Call .NET DLL, get result
;;; - cdd-parse-dialog-result: Parse delimited result string
;;; - cdd-show-dcl-fallback: Show DCL dialog if .NET fails

;;; SECTION 8: GEOMETRY UTILITIES
;;; - cdd-distance: Distance between two points
;;; - cdd-midpoint: Midpoint of two points
;;; - cdd-perpendicular-angle: Angle perpendicular to line
;;; - cdd-calculate-grade: Calculate grade from inverts and distance

;;; SECTION 9: DRAWING FUNCTIONS
;;; - cdd-collect-points: Get points from user
;;; - cdd-create-polyline: Draw polyline on pipe layer
;;; - cdd-create-mline: Draw MLINE on drainage layer

;;; SECTION 10: TEXT FUNCTIONS
;;; - cdd-create-pipe-text: Create pipe label
;;; - cdd-create-invert-text: Create invert label (TEXT or MTEXT)
;;; - cdd-calculate-text-position: Calculate auto-position for Quick Mode

;;; SECTION 11: ARROW FUNCTIONS
;;; - cdd-insert-arrow: Insert flow arrow block
;;; - cdd-calculate-arrow-position: Calculate arrow placement
;;; - cdd-calculate-flow-direction: Determine flow direction from inverts

;;; SECTION 12: MAIN COMMANDS
;;; - c:CDD: Main command
;;; - c:CDD-SETTINGS / c:CDDS: Settings command
;;; - c:CDD-MOVE-ARROW / c:CDDA / c:MFA: Move arrow command
;;; - (SETOFFSET removed - now in CDD-SETTINGS)
;;; - c:PIT: Place pit command (NEW)
;;; - c:PITSCHEDULE: Schedule editor command (NEW)

;;; SECTION 13: INITIALIZATION
;;; - Load .NET assembly on startup
;;; - Print load message
```

## 7.2 C# Project Structure

```
CDD_Dialog/
├── CDD_Dialog.csproj
├── Properties/
│   └── AssemblyInfo.cs
├── Models/
│   ├── CddSettings.cs          ← Settings data model
│   ├── PipeType.cs             ← Pipe type enum
│   ├── PitData.cs              ← Pit data model
│   └── PipeData.cs             ← Pipe data model
├── ViewModels/
│   ├── MainViewModel.cs        ← CDD dialog view model
│   ├── PitViewModel.cs         ← PIT dialog view model
│   └── ScheduleViewModel.cs    ← Schedule editor view model
├── Views/
│   ├── MainWindow.xaml         ← CDD dialog
│   ├── MainWindow.xaml.cs
│   ├── PitWindow.xaml          ← PIT dialog
│   ├── PitWindow.xaml.cs
│   ├── ScheduleWindow.xaml     ← Schedule editor
│   ├── ScheduleWindow.xaml.cs
│   └── Controls/
│       ├── SearchableComboBox.xaml
│       └── ArrowPreviewControl.xaml
├── Services/
│   ├── SettingsService.cs      ← JSON settings load/save
│   ├── ProjectDataService.cs   ← Project data management
│   └── DialogService.cs        ← COM-visible service for LISP
└── Themes/
    ├── DarkTheme.xaml
    └── LightTheme.xaml
```

## 7.3 COM Interface for LISP

```csharp
using System.Runtime.InteropServices;

namespace CDD
{
    [ComVisible(true)]
    [Guid("YOUR-GUID-HERE")]
    [ClassInterface(ClassInterfaceType.AutoDual)]
    public class DialogService
    {
        /// <summary>
        /// Shows the main CDD dialog and returns result as delimited string
        /// </summary>
        /// <returns>Delimited string: "diameter=100|material=UPVC|..."</returns>
        public string ShowMainDialog()
        {
            var window = new MainWindow();
            if (window.ShowDialog() == true)
            {
                return window.GetResult();
            }
            return "CANCELLED";
        }

        /// <summary>
        /// Shows the PIT dialog and returns result
        /// </summary>
        public string ShowPitDialog()
        {
            var window = new PitWindow();
            if (window.ShowDialog() == true)
            {
                return window.GetResult();
            }
            return "CANCELLED";
        }

        /// <summary>
        /// Shows the Schedule Editor
        /// </summary>
        public string ShowScheduleEditor()
        {
            var window = new ScheduleWindow();
            window.ShowDialog();
            return "CLOSED";
        }
    }
}
```

## 7.4 UCS Point Transformation

```lisp
;;; Transform point from current UCS to World coordinate system
;;; This is CRITICAL for correct placement when user has custom UCS
(defun cdd-transform-point (pt)
  "Transform point from UCS to World"
  (trans pt 1 0)  ; 1 = current UCS, 0 = World
)

;;; Example usage in point collection:
(defun cdd-collect-points ()
  (setq points nil)
  (while (setq pt (getpoint "\nPick point (Enter to finish): "))
    ;; Transform from UCS to World before storing
    (setq pt (cdd-transform-point pt))
    (setq points (append points (list pt)))
  )
  points
)
```

## 7.5 Text Masking Logic

**Regular TEXT (no mask):**
```lisp
(defun cdd-create-invert-text-regular (pt text angle)
  "Create regular TEXT (no background mask)"
  (entmake
    (list
      '(0 . "TEXT")
      '(100 . "AcDbEntity")
      (cons 8 "20TEXT")  ; Layer
      '(100 . "AcDbText")
      (cons 10 pt)       ; Insertion point
      (cons 40 180)      ; Text height
      (cons 1 text)      ; Text content
      (cons 50 angle)    ; Rotation
      (cons 72 1)        ; Horizontal justification: Center
      (cons 73 2)        ; Vertical justification: Middle
      (cons 11 pt)       ; Alignment point
    )
  )
)
```

**Masked MTEXT:**
```lisp
(defun cdd-create-invert-text-masked (pt text angle)
  "Create MTEXT with background mask"
  ;; Move text inward from endpoint
  (setq inward-distance 100)
  (setq adjusted-pt (polar pt (+ angle pi) inward-distance))

  (entmake
    (list
      '(0 . "MTEXT")
      '(100 . "AcDbEntity")
      (cons 8 "20TEXT")
      '(100 . "AcDbMText")
      (cons 10 adjusted-pt)  ; Insertion point
      (cons 40 180)          ; Text height
      (cons 1 text)          ; Text content
      (cons 50 angle)        ; Rotation
      (cons 71 5)            ; Attachment: Middle Center (5)
      (cons 90 1)            ; Background mask on
      (cons 63 256)          ; Background uses drawing background
      (cons 45 1.2)          ; Background scale factor
    )
  )

  ;; Bring to front
  (command "_.DRAWORDER" (entlast) "" "_FRONT")
)
```

---

# 8. DATA STORAGE & SETTINGS

## 8.1 User Settings (CDD_Settings.json)

Location: `%APPDATA%\TIMCADTOOLS\CDD_Settings.json`

```json
{
  "version": "4.0",
  "lastModified": "2026-01-15T10:30:00",

  "pipe": {
    "diameter": "100",
    "material": "UPVC",
    "type": "Stormwater Pipe",
    "recentDiameters": ["100", "150", "225"],
    "recentMaterials": ["UPVC", "RCP / RRJ"]
  },

  "inverts": {
    "firstValue": "1.10",
    "secondValue": "1.20",
    "firstRequired": true,
    "secondRequired": true,
    "useMask": false,
    "recentValues": ["1.10", "1.05", "0.95", "1.25", "1.15"]
  },

  "grade": {
    "method": "default",
    "customValue": ""
  },

  "destinations": {
    "risingMain": "PIT",
    "chargedPipe": "WT"
  },

  "options": {
    "createText": true,
    "insertArrow": true,
    "reverseArrow": false,
    "autoZoom": true,
    "includeInSchedule": true
  },

  "quickMode": {
    "all": false,
    "pipeText": false,
    "inverts": false
  },

  "batchMode": false,

  "theme": "auto",

  "osnap": {
    "drawing": 5247,
    "text": 0
  },

  "text": {
    "height": 250,
    "invertHeight": 180,
    "lineSpacing": 0.8,
    "backgroundScale": 1.2,
    "offset": 70,
    "invertInwardDistance": 100
  },

  "pit": {
    "lastNumber": "P4",
    "defaultSize": "450x450 Grated Pit",
    "defaultLidType": "Class A Grate"
  }
}
```

## 8.2 Project Data (CDD_ProjectData.json)

Location: `%APPDATA%\TIMCADTOOLS\CDD_ProjectData.json`

```json
{
  "drawingPath": "C:\\Projects\\12 Weatherly Grove\\Drainage.dwg",
  "lastModified": "2026-01-15T14:30:00",

  "pits": [
    {
      "id": "P1",
      "size": "450x450 Grated Pit",
      "coverLevel": "13.75",
      "lidType": "Class A Grate",
      "remarks": "Silt Pit",
      "position": [12500.0, 8750.0],
      "includeInSchedule": true,
      "entityHandle": "ABC123"
    },
    {
      "id": "P2",
      "size": "450x450 Grated Pit",
      "coverLevel": "13.70",
      "lidType": "Class A Grate",
      "remarks": "",
      "position": [15000.0, 8750.0],
      "includeInSchedule": true,
      "entityHandle": "ABC456"
    },
    {
      "id": "P3",
      "size": "600x600 Junction",
      "coverLevel": "13.65",
      "lidType": "Class B Grate",
      "remarks": "Junction pit",
      "position": [17500.0, 10000.0],
      "includeInSchedule": true,
      "entityHandle": "ABC789"
    }
  ],

  "pipes": [
    {
      "id": "PIPE_001",
      "from": "DP",
      "to": "P1",
      "diameter": "100",
      "material": "UPVC",
      "fromInvert": "13.70",
      "toInvert": "13.60",
      "grade": "100",
      "points": [[10000.0, 7500.0], [12500.0, 8750.0]],
      "includeInSchedule": true,
      "entityHandle": "DEF123"
    },
    {
      "id": "PIPE_002",
      "from": "WT",
      "to": "P1",
      "diameter": "100",
      "material": "UPVC",
      "fromInvert": "13.68",
      "toInvert": "13.60",
      "grade": "125",
      "points": [[11000.0, 6500.0], [12500.0, 8750.0]],
      "includeInSchedule": true,
      "entityHandle": "DEF456"
    },
    {
      "id": "PIPE_003",
      "from": "P1",
      "to": "P3",
      "diameter": "100",
      "material": "UPVC",
      "fromInvert": "13.60",
      "toInvert": "13.50",
      "grade": "200",
      "points": [[12500.0, 8750.0], [17500.0, 10000.0]],
      "includeInSchedule": true,
      "entityHandle": "DEF789"
    }
  ]
}
```

---

# 9. KNOWN ISSUES & FIXES

## 9.1 Quick Mode Invert Positioning Bug

**Problem:** Invert text positions incorrectly in certain pipe directions.

**Root Cause:** The perpendicular offset calculation doesn't account for all quadrants correctly.

**Fix:**
```lisp
(defun cdd-calculate-invert-position (endpoint pipe-angle side)
  "Calculate invert text position with correct offset for all directions"
  (setq offset-distance 100)
  (setq perp-angle
    (if (= side "left")
      (+ pipe-angle (/ pi 2))    ; Perpendicular left
      (- pipe-angle (/ pi 2))    ; Perpendicular right
    )
  )
  ;; Normalize angle to 0-2pi range
  (while (< perp-angle 0) (setq perp-angle (+ perp-angle (* 2 pi))))
  (while (>= perp-angle (* 2 pi)) (setq perp-angle (- perp-angle (* 2 pi))))

  (polar endpoint perp-angle offset-distance)
)
```

## 9.2 Text Masking Justification Bug

**Problem:** Regular TEXT and masked MTEXT use different justification systems, causing misalignment.

**Root Cause:**
- TEXT uses ML, MC, MR justification codes (DXF 72/73)
- MTEXT uses 1-9 attachment point codes (DXF 71)

**Fix:** Create separate functions for TEXT and MTEXT with correct justification handling:
- TEXT: Use (72 . 1) (73 . 2) for Middle Center
- MTEXT: Use (71 . 5) for Middle Center
- MTEXT: Apply inward distance offset of 100 units

## 9.3 UCS Support

**Problem:** Points not transformed to World coordinates when user has custom UCS.

**Fix:** Use `(trans pt 1 0)` to transform all picked points from UCS to World before storing/using.

## 9.4 Hardcoded DCL Path

**Problem:** DCL path hardcoded as `C:/Lisp Files/CDD_DCL.dcl`.

**Fix:** Detect base path dynamically:
```lisp
(setq *cdd-base-path*
  (if (findfile "C:/TIMCADTOOLS/CDD_Core.lsp")
    "C:/TIMCADTOOLS/"
    (getenv "TIMCADTOOLS_PATH")
  )
)
```

## 9.5 Duplicate c:CDD Definition

**Problem:** `c:CDD` defined twice in original file (lines 5001 and 10646).

**Fix:** Remove duplicate, keep single clean definition.

---

# 10. BUILD PHASES & TIMELINE

## Phase 1: CDD Core (LISP + .NET Dialog)

**Priority: HIGH**

| # | Task | Description |
|---|------|-------------|
| 1 | Create C# WPF project | Set up CDD_Dialog.dll project structure |
| 2 | Implement COM interface | DialogService class for LISP communication |
| 3 | Build main dialog UI | All sections visible, no tabs |
| 4 | Implement searchable dropdowns | Filterable combo boxes |
| 5 | Implement dark/light themes | Theme switching support |
| 6 | Create CDD_Core.lsp | Clean, modular LISP file |
| 7 | Add UCS support | Point transformation functions |
| 8 | Implement JSON settings | Load/save settings |
| 9 | Rebuild pipe drawing | Polyline and MLINE creation |
| 10 | Fix Quick Mode | Correct invert positioning |
| 11 | Fix Text Masking | TEXT vs MTEXT justification |
| 12 | Keep DCL fallback | Fallback if .NET fails |
| 13 | Test all directions | All pipe angles and orientations |

## Phase 2: PIT Command

**Priority: MEDIUM**

| # | Task | Description |
|---|------|-------------|
| 1 | Create PIT dialog | .NET WPF dialog |
| 2 | Pit number auto-increment | Scan drawing, suggest next number |
| 3 | Pit size dropdown | Searchable with custom option |
| 4 | Lid type dropdown | Searchable with custom option |
| 5 | Insert pit block | Place block at picked point |
| 6 | Add pit label text | Position relative to block |
| 7 | Add cover level text | Position relative to block |
| 8 | Store pit data | Save to CDD_ProjectData.json |

## Phase 3: PITSCHEDULE Command

**Priority: MEDIUM**

| # | Task | Description |
|---|------|-------------|
| 1 | Create Schedule Editor | .NET spreadsheet-style UI |
| 2 | Load project data | Read CDD_ProjectData.json |
| 3 | Editable cells | Click to edit any cell |
| 4 | Auto-calculate depth | Cover - Outlet IL |
| 5 | Refresh from drawing | Re-scan for pits/pipes |
| 6 | Import CSV | Import from external file |
| 7 | Export CSV | Export to external file |
| 8 | Place in schedule block | Insert MTEXT into drawing |

## Phase 4: Testing & Refinement

**Priority: HIGH**

| # | Task | Description |
|---|------|-------------|
| 1 | Test in AutoCAD 2022 | Primary target version |
| 2 | Test in AutoCAD 2024 | Verify compatibility |
| 3 | Test Quick Mode all directions | All 8 primary directions |
| 4 | Test Text Masking | TEXT and MTEXT in all directions |
| 5 | Test UCS scenarios | World and custom UCS |
| 6 | Test pit schedule workflow | End-to-end workflow |
| 7 | Performance testing | Large drawings |
| 8 | Error handling | Graceful failure recovery |

---

# 11. TESTING REQUIREMENTS

## 11.1 CDD Dialog Tests

- [ ] Dialog opens correctly
- [ ] Dark theme works
- [ ] Light theme works
- [ ] Theme auto-detection works
- [ ] Searchable dropdowns filter correctly
- [ ] Custom diameter entry works
- [ ] Custom material entry works
- [ ] All 5 pipe types create correct layers
- [ ] Charged pipe destination field works
- [ ] Rising main destination field works
- [ ] Grade default (1 in 100) works
- [ ] Grade calculate from inverts works
- [ ] Grade custom entry works
- [ ] Invert checkboxes enable/disable fields
- [ ] Recent values display and populate on click
- [ ] Arrow preview updates in real-time
- [ ] Simple pipe mode disables text/inverts sections
- [ ] Include in Schedule toggle works
- [ ] Batch mode toggle works
- [ ] Settings save to JSON
- [ ] Settings load from JSON on startup
- [ ] DCL fallback works if .NET fails

## 11.2 Quick Mode Direction Tests

- [ ] Horizontal pipe: left to right
- [ ] Horizontal pipe: right to left
- [ ] Vertical pipe: bottom to top
- [ ] Vertical pipe: top to bottom
- [ ] Diagonal pipe: Q1 (up-right)
- [ ] Diagonal pipe: Q2 (up-left)
- [ ] Diagonal pipe: Q3 (down-left)
- [ ] Diagonal pipe: Q4 (down-right)
- [ ] Multi-segment pipe

## 11.3 Text Masking Tests

- [ ] Regular TEXT horizontal
- [ ] Regular TEXT vertical
- [ ] Regular TEXT diagonal
- [ ] Masked MTEXT horizontal
- [ ] Masked MTEXT vertical
- [ ] Masked MTEXT diagonal
- [ ] Inward distance (100 units) applied correctly
- [ ] Background mask visible and scaled correctly

## 11.4 UCS Tests

- [ ] World UCS works correctly
- [ ] Custom UCS (rotated) works correctly
- [ ] Points transform correctly to World
- [ ] Text aligns correctly in custom UCS

## 11.5 PIT Command Tests

- [ ] Dialog opens correctly
- [ ] Pit number auto-increment works
- [ ] Pit size dropdown filters correctly
- [ ] Cover level entry validates numeric input
- [ ] Lid type dropdown works
- [ ] Plastic pit toggle excludes from schedule
- [ ] Pit block inserted at correct position
- [ ] Pit label text positioned correctly
- [ ] Cover level text positioned correctly
- [ ] Data saved to CDD_ProjectData.json

## 11.6 PITSCHEDULE Command Tests

- [ ] Editor opens correctly
- [ ] Data loads from CDD_ProjectData.json
- [ ] Multiple rows per pit display correctly
- [ ] Cells are editable
- [ ] Add row works
- [ ] Delete row works
- [ ] Move up/down works
- [ ] Refresh from drawing works
- [ ] CSV import works
- [ ] CSV export works
- [ ] Select schedule block works
- [ ] Place in schedule block positions text correctly
- [ ] Depth auto-calculation correct
- [ ] Warning highlight for shallow pits works

---

# 12. APPENDICES

## Appendix A: Layer Reference

| Layer Name | Color | Linetype | Purpose |
|------------|-------|----------|---------|
| `STORMWATER PIPE` | 150 | DASHED | Standard stormwater pipe |
| `STORMWATER UPVC CHARGED PIPE` | 10 | DASHED | Charged pipe |
| `STORMWATER SUSPENDED PIPE` | 211 | DASHED | Suspended pipe |
| `STORMWATER RISING MAIN` | 70 | DASHED | Rising main |
| `DRAINAGE` | 6 | CONTINUOUS | MLINE (most types) |
| `DRAINAGE HIDDEN` | 6 | HIDDEN | MLINE (suspended) |
| `25TEXT` | 7 | CONTINUOUS | Pipe labels |
| `20TEXT` | 10 | CONTINUOUS | Invert labels |
| `ARROW` | 7 | CONTINUOUS | Flow arrows |
| `35TEXT` | 2 (Yellow) | CONTINUOUS | Pit labels |

## Appendix B: Block Reference

| Block Name | Source | Purpose |
|------------|--------|---------|
| `TIM_CVL_ARROW` | TIM SETTINGS IMPORT.dwg | Flow direction arrow |
| Pit Block | `C:\Lisp Files\PIT BLOCK.dwg` | Dynamic pit block with 5 visibility states |
| Pit Label | `C:\Lisp Files\PIT LABEL.dwg` | Pit label block with 'FB' attribute |
| Pit Schedule | `C:\Lisp Files\Pit Schedule.dwg` | Schedule table template |

## Appendix C: File Paths

| File | Path |
|------|------|
| LISP Core | `C:\TIMCADTOOLS\CDD_Core.lsp` |
| CDD Dialog DLL | `C:\TIMCADTOOLS\CDD_Dialog.dll` |
| PIT Dialog DLL | `C:\TIMCADTOOLS\PIT_Dialog.dll` |
| Schedule Editor DLL | `C:\TIMCADTOOLS\Schedule_Editor.dll` |
| DCL Fallback | `C:\TIMCADTOOLS\CDD_DCL.dcl` |
| User Settings | `%APPDATA%\TIMCADTOOLS\CDD_Settings.json` |
| Project Data | `%APPDATA%\TIMCADTOOLS\CDD_ProjectData.json` |
| Pit Block | `C:\Lisp Files\PIT BLOCK.dwg` |
| Pit Label Block | `C:\Lisp Files\PIT LABEL.dwg` |
| Pit Schedule Block | `C:\Lisp Files\Pit Schedule.dwg` |

## Appendix D: OSNAP Values

| Mode | Value | Snaps |
|------|-------|-------|
| Drawing Phase | 5247 | END, MID, CEN, INT, EXT |
| Text Phase | 0 | None (free placement) |

## Appendix E: Glossary

| Term | Definition |
|------|------------|
| AHD | Australian Height Datum - standard elevation reference |
| CL | Cover Level - surface level at pit |
| IL | Invert Level - bottom inside of pipe |
| DP | Downpipe - roof drainage |
| WT | Water Tank |
| SPS | Stormwater Pump Station |
| MLINE | Multi-line - AutoCAD entity with width |
| UCS | User Coordinate System |
| DCL | Dialog Control Language - AutoCAD dialog format |
| COM | Component Object Model - Windows interop technology |

---

# REVISION HISTORY

| Date | Version | Author | Changes |
|------|---------|--------|---------|
| 2026-01-15 | 1.0 | Claude Code | Initial complete specification |
| 2026-01-16 | 1.1 | Claude Code | Added confirmed answers to all questions, updated PIT command spec with block details, geometry layers, MTEXT positioning |

---

# 13. CONFIRMED DECISIONS (Questions Answered)

All questions have been reviewed and answered. Here is the summary of confirmed decisions:

## 13.1 Pit Block Decisions - CONFIRMED

| # | Question | Answer |
|---|----------|--------|
| Q1 | **Pit Label Position** | User selects position (TL, TR, BL, BR) via preview in dialog. Uses `PIT LABEL.dwg` block with 'FB' attribute |
| Q2 | **Cover Level Text Position** | MTEXT at corner of imaginary Layer 3 (200 units from pit edge). Rotation: 315° (TL, SE) or 45° (TR, BL). Justify: Middle Right (left-side) or Middle Left (right-side) |
| Q3 | **Pit Invert Text Position** | Always BELOW the CL line in the same MTEXT block |
| Q4 | **Pit Blocks** | User provides `C:\Lisp Files\PIT BLOCK.dwg` with 5 visibility states (GRATED, SOLID, SPS GRATED, SPS SOLID, DETENTION) |

## 13.2 Auto-Detection Decisions - CONFIRMED

| # | Question | Answer |
|---|----------|--------|
| Q5 | **Detection Radius** | **100 units** |
| Q6 | **DP/WT Symbol Detection** | **Manual input only** - dynamic downpipes and water tanks are too complex for auto-detection |

## 13.3 Schedule Block Decisions - CONFIRMED

| # | Question | Answer |
|---|----------|--------|
| Q7 | **Schedule Template** | Yes, existing block at `C:\Lisp Files\Pit Schedule.dwg`. Future: auto-import if not present |
| Q8 | **Schedule Text Placement** | User selects insertion point for schedule block. Text offset from insertion point is **(100, -2450)** using CIVIL EXCEL IMPORTER approach |

## 13.4 Workflow Decisions - CONFIRMED

| # | Question | Answer |
|---|----------|--------|
| Q9 | **Text Style** | **STANDARD** - inherit from current drawing settings |
| Q10 | **Layer Colors** | **Keep all current colors** (150, 10, 211, 70, etc.) |

## 13.5 Priority Decisions - CONFIRMED

| # | Question | Answer |
|---|----------|--------|
| Q11 | **Build Order** | **All three in parallel** - that's why we're planning thoroughly first |
| Q12 | **DCL Fallback** | **Minimal effort** - current DCL works well, just keep existing as fallback |

---

## READY FOR IMPLEMENTATION

All questions have been answered and specifications confirmed. The document is now complete and ready to guide implementation.

**Key Files:**
- Pit Block: `C:\Lisp Files\PIT BLOCK.dwg`
- Pit Label: `C:\Lisp Files\PIT LABEL.dwg`
- Pit Schedule: `C:\Lisp Files\Pit Schedule.dwg`

---

**END OF DOCUMENT**

*This document was created during the CDD v4.0 planning session and contains the complete specification for the rebuild project.*
*Last updated: 2026-01-16 with all confirmed decisions.*
