# CDD v4.0 - Civil Drainage Design System
## Planning Document

**Created:** 2026-01-15
**Status:** Planning Phase
**Original Files:**
- `c:\Lisp Files\CDD COMMAND.lsp` (490KB)
- `c:\Lisp Files\CDD_DCL.dcl` (558 lines)

---

## TABLE OF CONTENTS

1. [Project Overview](#1-project-overview)
2. [Current System Analysis](#2-current-system-analysis)
3. [New System Architecture](#3-new-system-architecture)
4. [Dialog Designs](#4-dialog-designs)
5. [Features & Functionality](#5-features--functionality)
6. [Settings System](#6-settings-system)
7. [Layers & Text Settings](#7-layers--text-settings)
8. [Pit Schedule Integration](#8-pit-schedule-integration)
9. [Build Order & Phases](#9-build-order--phases)
10. [Testing Checklist](#10-testing-checklist)

---

## 1. PROJECT OVERVIEW

### 1.1 Goals
- Replace dated DCL dialogs with modern .NET WPF popups
- Fix Quick Mode functionality (invert positioning issues)
- Fix Text Masking functionality (regular TEXT vs masked MTEXT)
- Add UCS support for point transformation
- Consolidate settings into single JSON file
- Integrate with Pit Schedule system
- Support both dark and light themes
- Keep DCL as fallback option

### 1.2 Commands

| Command | Description | Status |
|---------|-------------|--------|
| `CDD` | Main drainage pipe drawing command | Rebuild |
| `CDD-SETTINGS` / `CDDS` | Advanced settings dialog | Rebuild |
| `CDD-MOVE-ARROW` / `CDDA` / `MFA` | Move arrow to different segment | Keep |
| `SETOFFSET` | Set text offset distance | Keep |
| `PIT` | Place pit with details (NEW) | New |
| `PITSCHEDULE` | Schedule editor spreadsheet (NEW) | New |

### 1.3 Technology Stack
- **LISP:** AutoLISP for AutoCAD integration
- **Dialog:** C# WPF (.NET Framework 4.7.2+)
- **Communication:** COM Object interface
- **Settings:** JSON file storage
- **Target:** AutoCAD 2022+ (multi-version compatible)

---

## 2. CURRENT SYSTEM ANALYSIS

### 2.1 Existing Commands

| Command | Alias | Description |
|---------|-------|-------------|
| `CDD` | - | Main civil drainage design command |
| `CDD-SETTINGS` | `CDDS` | Advanced settings dialog |
| `CDD-OSNAP` | - | Configure OSNAP settings |
| `CDD-MOVE-ARROW` | `CDDA`, `MFA` | Move flow arrow to different segment |
| `SETOFFSET` | - | Set text offset distance |

### 2.2 Existing Layers

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

### 2.3 Existing Text Settings

| Setting | Value | Purpose |
|---------|-------|---------|
| `*CDD-TEXT-HEIGHT*` | 250 | Pipe label text height |
| `*CDD-TEXT-LINE-SPACING*` | 0.8 | Line spacing factor |
| `*CDD-TEXT-BACKGROUND-SCALE*` | 1.2 | Background mask scale |
| `*CDD-TEXT-DEFAULT-OFFSET*` | 70 | Text offset from pipe |
| `*CDD-INVERT-TEXT-HEIGHT*` | 180 | Invert level text height |
| `*CDD-INVERT-INWARD-DISTANCE*` | 100 | Masked invert offset |

### 2.4 Existing Global Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `*cdd-osmode-original*` | nil | Stores OSMODE before CDD starts |
| `*cdd-dcl-id*` | nil | Dialog ID for cleanup |
| `*cdd-active*` | nil | Flag if CDD is running |
| `*cdd-layer-original*` | nil | Stores layer before CDD |
| `*tb_drain_diameter*` | "100" | Pipe diameter |
| `*tb_drain_material*` | "UPVC" | Pipe material |
| `*tb_drain_grade*` | "100" | Pipe grade (1 in X) |
| `*tb_drain_pipe_type*` | "Stormwater Pipe" | Selected pipe type |
| `*tb_drain_lh_invert*` | "Not Required" | First point invert |
| `*tb_drain_rh_invert*` | "Not Required" | Second point invert |
| `*tb_drain_simple_pipe*` | nil | Simple pipe mode |
| `*tb_drain_text_needed*` | T | Create pipe text? |
| `*tb_drain_insert_arrow*` | T | Insert flow arrow? |
| `*tb_drain_reverse_arrow*` | nil | Reverse arrow direction? |
| `*tb_invert_mask*` | nil | Mask invert text? |
| `*tb_quickmode_all*` | nil | Auto-place all |
| `*tb_quickmode_pipetext*` | nil | Auto-place pipe text |
| `*tb_quickmode_inverts*` | nil | Auto-place inverts |
| `*tb_enable_zoom*` | T | Auto-zoom to pipe |
| `*cdd-osmode-drawing*` | 5247 | OSMODE for drawing phase |
| `*cdd-osmode-text*` | 5887 | OSMODE for text phase |

### 2.5 Known Issues to Fix

1. **No UCS Support** - Points not transformed to World coordinates
2. **Hardcoded Path** - DCL path hardcoded as `C:/Lisp Files/CDD_DCL.dcl`
3. **Duplicate Code** - Main command `c:CDD` defined twice
4. **Quick Mode** - Invert positions not working correctly in certain directions
5. **Text Masking** - Regular TEXT vs masked MTEXT have different justification logic
6. **Large File** - 490KB single file is hard to maintain

---

## 3. NEW SYSTEM ARCHITECTURE

### 3.1 File Structure

```
C:\TIMCADTOOLS\
├── CDD_Core.lsp              ← Main LISP file (consolidated)
├── CDD_Dialog.dll            ← .NET dialog for CDD command
├── PIT_Dialog.dll            ← .NET dialog for PIT command
├── Schedule_Editor.dll       ← .NET spreadsheet editor
├── CDD_Settings.json         ← User settings (persistent)
├── CDD_ProjectData.json      ← Current drawing's pipe/pit data
├── CDD_DCL.dcl               ← DCL fallback (if .NET fails)
└── Blocks\
    └── TIM_CVL_ARROW.dwg     ← Arrow block
```

### 3.2 LISP Module Structure

```
;;; =====================================================================
;;; SECTION 1: CONFIGURATION
;;; =====================================================================
;;; - Base path detection (dynamic)
;;; - Layer definitions table
;;; - Text settings table
;;; - Block names

;;; =====================================================================
;;; SECTION 2: GLOBAL VARIABLES
;;; =====================================================================
;;; - Runtime state variables
;;; - Dialog result storage

;;; =====================================================================
;;; SECTION 3: ERROR HANDLING
;;; =====================================================================
;;; - *error* function with full restore
;;; - cdd-cleanup function

;;; =====================================================================
;;; SECTION 4: UCS UTILITIES (NEW)
;;; =====================================================================
;;; - cdd-is-ucs-world
;;; - cdd-store-ucs
;;; - cdd-restore-ucs
;;; - cdd-transform-point (UCS to World)

;;; =====================================================================
;;; SECTION 5: LAYER MANAGEMENT
;;; =====================================================================
;;; - cdd-set-layer (create if needed)
;;; - cdd-get-pipe-layer-props
;;; - cdd-bring-layers-to-front

;;; =====================================================================
;;; SECTION 6: SETTINGS MANAGEMENT
;;; =====================================================================
;;; - cdd-load-settings (from JSON)
;;; - cdd-save-settings (to JSON)
;;; - cdd-get-setting / cdd-set-setting

;;; =====================================================================
;;; SECTION 7: .NET DIALOG INTERFACE
;;; =====================================================================
;;; - cdd-show-dialog (calls .NET DLL)
;;; - cdd-parse-dialog-result
;;; - cdd-show-dcl-fallback

;;; =====================================================================
;;; SECTION 8: GEOMETRY UTILITIES
;;; =====================================================================
;;; - cdd-distance
;;; - cdd-midpoint
;;; - cdd-perpendicular-angle
;;; - cdd-calculate-grade

;;; =====================================================================
;;; SECTION 9: DRAWING FUNCTIONS
;;; =====================================================================
;;; - cdd-collect-points
;;; - cdd-create-polyline
;;; - cdd-create-mline

;;; =====================================================================
;;; SECTION 10: TEXT FUNCTIONS
;;; =====================================================================
;;; - cdd-create-pipe-text
;;; - cdd-create-invert-text (handles both TEXT and MTEXT)
;;; - cdd-calculate-text-position (for Quick Mode)

;;; =====================================================================
;;; SECTION 11: ARROW FUNCTIONS
;;; =====================================================================
;;; - cdd-insert-arrow
;;; - cdd-calculate-arrow-position
;;; - cdd-calculate-flow-direction

;;; =====================================================================
;;; SECTION 12: MAIN COMMANDS
;;; =====================================================================
;;; - c:CDD (main command)
;;; - c:CDD-SETTINGS / c:CDDS
;;; - c:CDD-MOVE-ARROW / c:CDDA / c:MFA
;;; - c:SETOFFSET
;;; - c:PIT (new)
;;; - c:PITSCHEDULE (new)

;;; =====================================================================
;;; SECTION 13: INITIALIZATION
;;; =====================================================================
;;; - Load .NET assembly
;;; - Print load message
```

### 3.3 LISP ↔ .NET Communication

**Method: COM Object Interface**

```lisp
;; Step 1: Load the .NET DLL (once when AutoCAD starts)
(command "NETLOAD" "C:/TIMCADTOOLS/CDD_Dialog.dll")

;; Step 2: Create a connection to the .NET dialog
(setq dialog-service (vlax-create-object "CDD.DialogService"))

;; Step 3: Tell .NET to show the dialog, get result back
(setq result (vlax-invoke dialog-service 'ShowMainDialog))

;; Step 4: Result comes back as delimited text:
;; "diameter=100|material=UPVC|pipetype=1|grade=100|..."

;; Step 5: LISP parses this text and uses the values
(setq diameter (cdd-get-result-value result "diameter"))

;; Step 6: Clean up
(vlax-release-object dialog-service)
```

### 3.4 C# Project Structure

```
CDD_Dialog/
├── CDD_Dialog.csproj
├── Properties/
│   └── AssemblyInfo.cs
├── Models/
│   ├── CddSettings.cs
│   ├── PipeType.cs
│   └── PitData.cs
├── ViewModels/
│   ├── MainViewModel.cs
│   └── SettingsViewModel.cs
├── Views/
│   ├── MainWindow.xaml
│   ├── MainWindow.xaml.cs
│   ├── SettingsWindow.xaml
│   └── ArrowPreviewControl.xaml
├── Services/
│   ├── SettingsService.cs
│   ├── AutoCADInterface.cs
│   └── DialogService.cs (COM-visible)
└── Themes/
    ├── DarkTheme.xaml
    └── LightTheme.xaml
```

---

## 4. DIALOG DESIGNS

### 4.1 Main CDD Dialog (All Sections Visible)

```
┌────────────────────────────────────────────────────────────────────────────────┐
│  CDD v4.0 - Civil Drainage Design                    [☀/🌙]        [─][□][×]  │
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

### 4.2 Searchable Dropdown Behavior

```
┌─ Diameter ──────────────────┐
│ [ 15                     ▼] │  ← User types "15"
├─────────────────────────────┤
│ ► 150                       │  ← Filtered to show matches
│   Custom...                 │
└─────────────────────────────┘
```

- Click dropdown OR just start typing
- List filters as you type
- Arrow keys to navigate
- Enter to select
- If no match, shows "Custom..." option

### 4.3 Place Pit Dialog (NEW)

```
┌────────────────────────────────────────────────────────────────────────────┐
│  Place Stormwater Pit                                        [─][□][×]    │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                            │
│  ┌─ PIT DETAILS ──────────────────────────────────────────────────────┐   │
│  │                                                                     │   │
│  │  Pit Number:    [ P1        ]  [Auto ▼]                            │   │
│  │                                                                     │   │
│  │  Pit Size:      [ 450x450 Grated Pit              ▼]               │   │
│  │                 (searchable - see pit sizes list)                   │   │
│  │                                                                     │   │
│  │  Cover Level:   [ 13.75     ]  m AHD                               │   │
│  │                                                                     │   │
│  │  Lid Type:      [ Class A Grate                   ▼]               │   │
│  │                                                                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                            │
│  ┌─ CONNECTED PIPES (Auto-detected) ──────────────────────────────────┐   │
│  │                                                                     │   │
│  │  INLETS:                        OUTLET:                            │   │
│  │  ┌──────┬─────┬────────┐       ┌──────┬─────┬────────┐            │   │
│  │  │ FROM │ DIA │ INV.LV │       │  TO  │ DIA │ INV.LV │            │   │
│  │  ├──────┼─────┼────────┤       ├──────┼─────┼────────┤            │   │
│  │  │ DP   │ 100 │ 13.70  │       │ P3   │ 150 │ 13.60  │            │   │
│  │  │ P2   │ 150 │ 13.65  │       └──────┴─────┴────────┘            │   │
│  │  └──────┴─────┴────────┘                                           │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                            │
│  ┌─ CALCULATED ───────────────────────────────────────────────────────┐   │
│  │  Depth to Outlet:  0.15m   (Cover 13.75 - Outlet IL 13.60)        │   │
│  │  ⚠ Warning: Depth < 0.30m - Check design                          │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                            │
│  Remarks: [ Silt Pit                                                  ]   │
│                                                                            │
│  ☑ Add pit label    ☑ Add to schedule                                    │
│                                                                            │
│              [ Place Pit ]         [ Cancel ]                              │
└────────────────────────────────────────────────────────────────────────────┘
```

### 4.4 Pit Schedule Editor (NEW)

```
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│  Stormwater Pit Schedule Editor                                              [─][□][×]      │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│  [ + Add ]  [ − Delete ]  [ ↑ ]  [ ↓ ]  [ Refresh from Drawing ]  [ Import CSV ]           │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│  ┌─────┬───────────────────┬───────────────────────────┬───────────────────────────┬───────┐│
│  │     │                   │         INLET             │         OUTLET            │       ││
│  │ PIT │     PIT SIZE      ├───────┬─────┬─────────────┼─────┬─────────────┬───────┤ DEPTH ││
│  │ No. │                   │ FROM  │ DIA │ INVERT LVL  │ DIA │ INVERT LVL  │ COVER │       ││
│  ├─────┼───────────────────┼───────┼─────┼─────────────┼─────┼─────────────┼───────┼───────┤│
│  │ P1  │ 450x450 Grated    │ DP    │ 100 │    13.70    │ 100 │    13.60    │ 13.75 │ 0.15  ││
│  │ P2  │ 450x450 Grated    │ DP    │ 100 │    13.65    │ 150 │    13.55    │ 13.70 │ 0.15  ││
│  │ P3  │ 600x600 Junction  │ P1,P2 │ ... │    ...      │ 150 │    13.50    │ 13.65 │ 0.15  ││
│  └─────┴───────────────────┴───────┴─────┴─────────────┴─────┴─────────────┴───────┴───────┘│
│  ← Scroll for: LID TYPE, REMARKS →                                                          │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│  ☑ Auto-calculate DEPTH    ☑ Highlight warnings                                            │
│  Schedule Block: [ Select in Drawing ]  Currently: (not selected)                           │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│     [ Place in Schedule Block ]      [ Export CSV ]      [ Cancel ]                         │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 5. FEATURES & FUNCTIONALITY

### 5.1 Pipe Diameter Options

Common sizes (in dropdown):
- 100
- 150
- 225
- 300
- 450
- Custom... (opens input dialog)

### 5.2 Pipe Material Options

Common materials (in dropdown):
- UPVC
- RCP / RRJ
- UPVC SEWER CLASS
- RCP
- STORMPRO
- Custom... (opens input dialog)

### 5.3 Pipe Types

| Type | Layer | Color | Destination Field |
|------|-------|-------|-------------------|
| Stormwater Pipe | STORMWATER PIPE | 150 | None |
| Stormwater Charged Pipe | STORMWATER UPVC CHARGED PIPE | 10 | WT (typical) |
| Stormwater Suspended Pipe | STORMWATER SUSPENDED PIPE | 211 | None |
| Stormwater Rising Main | STORMWATER RISING MAIN | 70 | PIT (typical) |
| Stormwater Detention Pipe | STORMWATER PIPE | 150 | None |

### 5.4 Pit Sizes (from existing dropdown)

- 350x350 Grated Pit
- 350x350 Junction Pit
- 450x450 Grated Pit
- 450x450 Junction Pit
- 600x600 Grated Pit
- 600x600 Junction
- 600x900 Grated Pit
- 600x900 Junction
- 750x750 Grated Pit
- 900x900 Junction Pit
- 900x900 Grated Pit
- 600x1200 Detention Pit
- SPS Vertical
- SPS Horizontal
- Enviss Sentinel
- Settling Tank
- Custom...

### 5.5 Lid Types

- Class A Grate
- Class B Grate
- Class C Grate
- Class D Cover
- Trafficable Cover
- Custom...

### 5.6 Quick Mode Logic

```
IF Quick Mode ALL enabled:
  - Pipe text position = midpoint of first segment + offset perpendicular (above)
  - Arrow position = midpoint + (radius + 125) perpendicular (below)
  - First invert position = near first point with offset
  - Second invert position = near second point with offset
  - NO user prompts for placement

IF Quick Mode Pipe Text Only:
  - Auto-place pipe text (calculated position)
  - Prompt for invert positions manually

IF Quick Mode Inverts Only:
  - Prompt for pipe text position manually
  - Auto-place inverts (calculated positions)
```

### 5.7 Text Masking Logic

**Regular TEXT (no mask):**
- Uses TEXT command
- Justification: ML, MC, MR, etc.
- Position aligns directly to insertion point

**Masked MTEXT:**
- Uses MTEXT command with background fill
- Justification: 1-9 (attachment points)
- Move text inward from endpoint by INWARD_DISTANCE (100 units)
- Background scale factor = 1.2
- Ensure layer is on top (DRAWORDER)

### 5.8 Batch Mode

When enabled:
```
After drawing first pipe:
  "Draw another pipe with same settings? [Yes/No]"
  > Yes = repeat point collection, keep same settings
  > No = exit command
```

### 5.9 Recent Values

- Store last 5 unique values for:
  - Diameters
  - Materials
  - Invert levels
- Click to populate field
- Saved in settings JSON

---

## 6. SETTINGS SYSTEM

### 6.1 Settings File Location

```
C:\Users\[Username]\AppData\Roaming\TIMCADTOOLS\CDD_Settings.json
```

### 6.2 Settings JSON Structure

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
    "autoZoom": true
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
  "defaults": {
    "invertPosition": "Top",
    "mirrorText": "No"
  },
  "text": {
    "height": 250,
    "invertHeight": 180,
    "lineSpacing": 0.8,
    "backgroundScale": 1.2,
    "offset": 70,
    "invertInwardDistance": 100
  }
}
```

---

## 7. LAYERS & TEXT SETTINGS

### 7.1 Layer Definitions (UNCHANGED)

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
| `35TEXT` | 2 (Yellow) | CONTINUOUS | Schedule pit numbers |

### 7.2 Text Settings (UNCHANGED)

| Setting | Value |
|---------|-------|
| Pipe text height | 250 |
| Invert text height | 180 |
| Line spacing factor | 0.8 |
| Background scale | 1.2 |
| Text offset | 70 |
| Invert inward distance | 100 |

### 7.3 Block References

| Block Name | Purpose |
|------------|---------|
| `TIM_CVL_ARROW` | Flow direction arrow |
| `TIM SETTINGS IMPORT` | Settings/styles block |

---

## 8. PIT SCHEDULE INTEGRATION

### 8.1 Key Workflow Clarifications

**IMPORTANT: PITS ARE PLACED FIRST, THEN PIPES CONNECT BETWEEN THEM**

- User places pits using PIT command (with block, label, cover level)
- User then draws pipes using CDD command to connect between pits
- Not ALL pipes go in the schedule - only pipes that are inlets to labelled pits
- CDD dialog has "Include in Pit Schedule" toggle to control this
- Plastic pits (PP) are NOT included in the schedule

### 8.2 FROM Field Values

Inlet pipes can come from:
- **WT** - Water Tank / Water connection
- **DP** - Downpipe (from roof)
- **SPS** - Stormwater Pump Station
- **Another Pit** - e.g., P1, P2, P3
- **Custom** - User-entered value

### 8.3 Multiple Inlets Per Pit

A single pit can have MULTIPLE inlet pipes. Each inlet creates a SEPARATE ROW in the schedule:

```
Example: Pit P3 receives pipes from P1 and P2
┌─────┬───────────────────┬───────┬─────┬─────────────┬─────┬─────────────┬───────┬───────┐
│ PIT │     PIT SIZE      │ FROM  │ DIA │ INLET IL    │ DIA │ OUTLET IL   │ COVER │ DEPTH │
├─────┼───────────────────┼───────┼─────┼─────────────┼─────┼─────────────┼───────┼───────┤
│ P3  │ 600x600 Junction  │ P1    │ 100 │    13.60    │ 150 │    13.50    │ 13.65 │ 0.15  │
│ P3  │ 600x600 Junction  │ P2    │ 150 │    13.55    │ 150 │    13.50    │ 13.65 │ 0.15  │
└─────┴───────────────────┴───────┴─────┴─────────────┴─────┴─────────────┴───────┴───────┘
```

### 8.4 Workflow

```
STEP 1: PLACE PITS (PIT Command) - FIRST
├── User runs PIT command
├── .NET dialog opens FIRST (before placement)
├── User enters: Pit Number, Size, Cover Level, Lid Type
├── User selects "Include in Schedule" toggle (or "Plastic Pit" = not in schedule)
├── User clicks OK, then picks insertion point
├── System inserts pit block with label and cover level text
└── Pit data saved to CDD_ProjectData.json

STEP 2: DRAW PIPES (CDD Command)
├── User draws pipes connecting pits with CDD
├── CDD dialog has "Include in Pit Schedule" toggle
├── If toggled ON: System tracks pipe for schedule
├── System auto-detects nearest pit at pipe endpoints
├── Data saved to CDD_ProjectData.json
└── If toggled OFF: Pipe not tracked (e.g., minor drainage)

STEP 3: REVIEW SCHEDULE (PITSCHEDULE Command)
├── .NET spreadsheet shows all tracked pits and connections
├── One row per INLET (multiple rows for pits with multiple inlets)
├── User can edit, add, delete rows
├── "Refresh from Drawing" re-scans for pits/pipes
└── "Place in Schedule Block" inserts text into schedule template
```

### 8.5 Auto-Detection Logic

When a pipe endpoint is within a detection radius of a pit:
- System automatically links pipe to that pit
- FROM/TO fields populated automatically
- If endpoint near DP symbol → FROM = "DP"
- If endpoint near WT symbol → FROM = "WT"
- If endpoint near pit block → FROM = pit number (e.g., "P1")
- If no match found → user manually enters FROM value

### 8.2 Schedule Columns

| Column | Description | Auto/Manual |
|--------|-------------|-------------|
| PIT No. | Pit identifier (P1, P2...) | Manual (auto-increment option) |
| PIT SIZE | Pit dimensions | Manual (from dropdown) |
| FROM (Inlet) | Where pipe comes from | Auto-detected from pipes |
| DIA (Inlet) | Inlet pipe diameter | Auto-detected from pipes |
| INVERT LEVEL (Inlet) | Inlet invert | Auto-detected from pipes |
| DIA (Outlet) | Outlet pipe diameter | Auto-detected from pipes |
| INVERT LEVEL (Outlet) | Outlet invert | Auto-detected from pipes |
| COVER LEVEL | Surface level at pit | Manual entry |
| DEPTH TO OUTLET | Calculated depth | Auto (Cover - Outlet IL) |
| TYPE OF LID | Lid/grate type | Manual (from dropdown) |
| REMARKS | Additional notes | Manual |

### 8.3 Project Data JSON Structure

```json
{
  "projectName": "12 Weatherly Grove",
  "pipes": [
    {
      "id": "PIPE_001",
      "fromPit": "P1",
      "toPit": "P3",
      "diameter": "100",
      "material": "UPVC",
      "firstInvert": "13.60",
      "secondInvert": "13.50",
      "grade": "100",
      "points": [[x1,y1], [x2,y2]]
    }
  ],
  "pits": [
    {
      "id": "P1",
      "size": "450x450 Grated Pit",
      "coverLevel": "13.75",
      "lidType": "Class A Grate",
      "remarks": "",
      "position": [x, y]
    }
  ]
}
```

---

## 9. BUILD ORDER & PHASES

### Phase 1: CDD Core (LISP + .NET Dialog)

**Priority: HIGH**

Tasks:
1. Create C# WPF project (CDD_Dialog.dll)
2. Implement COM interface for LISP communication
3. Build main dialog UI (all sections visible)
4. Implement searchable dropdowns
5. Implement dark/light theme switching
6. Create new CDD_Core.lsp
7. Add UCS support functions
8. Implement JSON settings load/save
9. Rebuild pipe drawing functions
10. Fix Quick Mode invert positioning
11. Fix Text Masking (TEXT vs MTEXT)
12. Keep DCL as fallback
13. Test all pipe types and directions

### Phase 2: PIT Command

**Priority: MEDIUM**

Tasks:
1. Create PIT_Dialog.dll
2. Build pit placement dialog UI
3. Implement pit size dropdown (with custom)
4. Implement lid type dropdown
5. Auto-detect connected pipes
6. Auto-calculate depth
7. Add pit labels to drawing
8. Store pit data in project JSON

### Phase 3: Schedule Editor

**Priority: MEDIUM**

Tasks:
1. Create Schedule_Editor.dll
2. Build spreadsheet-style UI
3. Implement editable cells
4. Import/export CSV
5. Refresh from drawing data
6. Place text into schedule block
7. Integrate with CIVILEXCELMTEXT positioning logic

### Phase 4: Testing & Refinement

**Priority: HIGH**

Tasks:
1. Test all commands in AutoCAD 2022
2. Test in other AutoCAD versions
3. Test Quick Mode all directions
4. Test Text Masking all directions
5. Test pit schedule workflow
6. Performance testing
7. Error handling testing

---

## 10. TESTING CHECKLIST

### 10.1 CDD Command Tests

- [ ] Dialog opens correctly
- [ ] Dark theme works
- [ ] Light theme works
- [ ] Theme auto-detection works
- [ ] Searchable dropdowns filter correctly
- [ ] Custom diameter entry works
- [ ] Custom material entry works
- [ ] All pipe types create correct layers
- [ ] Charged pipe destination field works
- [ ] Rising main destination field works
- [ ] Grade default (1 in 100) works
- [ ] Grade calculate from inverts works
- [ ] Grade custom entry works
- [ ] Invert toggles enable/disable fields
- [ ] Recent values display and populate
- [ ] Arrow preview updates in real-time
- [ ] Simple pipe mode disables text/inverts
- [ ] Quick Mode ALL auto-places everything
- [ ] Quick Mode Pipe Text auto-places text only
- [ ] Quick Mode Inverts auto-places inverts only
- [ ] Batch mode prompts for another pipe
- [ ] Auto-zoom works
- [ ] Settings save to JSON
- [ ] Settings load from JSON
- [ ] DCL fallback works if .NET fails

### 10.2 Direction Tests (Quick Mode)

- [ ] Horizontal pipe (left to right)
- [ ] Horizontal pipe (right to left)
- [ ] Vertical pipe (bottom to top)
- [ ] Vertical pipe (top to bottom)
- [ ] Diagonal pipe (all quadrants)
- [ ] Multi-segment pipe

### 10.3 Text Masking Tests

- [ ] Regular TEXT horizontal
- [ ] Regular TEXT vertical
- [ ] Regular TEXT diagonal
- [ ] Masked MTEXT horizontal
- [ ] Masked MTEXT vertical
- [ ] Masked MTEXT diagonal
- [ ] Inward distance applied correctly
- [ ] Background mask visible

### 10.4 UCS Tests

- [ ] World UCS works
- [ ] Custom UCS works
- [ ] Points transform correctly
- [ ] Text aligns correctly in UCS

### 10.5 PIT Command Tests

- [ ] Dialog opens correctly
- [ ] Pit number auto-increment works
- [ ] Pit size dropdown works
- [ ] Cover level entry works
- [ ] Lid type dropdown works
- [ ] Connected pipes auto-detected
- [ ] Depth auto-calculated
- [ ] Pit label placed in drawing
- [ ] Data saved to project JSON

### 10.6 Schedule Editor Tests

- [ ] Editor opens correctly
- [ ] Data loads from project JSON
- [ ] Cells are editable
- [ ] Add row works
- [ ] Delete row works
- [ ] Move up/down works
- [ ] Refresh from drawing works
- [ ] CSV import works
- [ ] CSV export works
- [ ] Place in schedule block works
- [ ] Text positions correctly in schedule

---

## APPENDIX A: Block Names Reference

| Block | File Location | Purpose |
|-------|---------------|---------|
| TIM_CVL_ARROW | TIM SETTINGS IMPORT.dwg | Flow arrow |
| Pit Schedule | (user's template) | Schedule table |

## APPENDIX B: Environment Variables (Legacy)

These will be migrated to JSON settings:

| Variable | Purpose |
|----------|---------|
| CD_LH_INVERT | Last LH invert |
| CD_RH_INVERT | Last RH invert |
| CVLOFFSETDISTANCE | Text offset |
| CDD_OSNAP_* | OSNAP settings |

## APPENDIX C: File Paths

| File | Path |
|------|------|
| LISP | C:\TIMCADTOOLS\CDD_Core.lsp |
| Main Dialog DLL | C:\TIMCADTOOLS\CDD_Dialog.dll |
| Pit Dialog DLL | C:\TIMCADTOOLS\PIT_Dialog.dll |
| Schedule DLL | C:\TIMCADTOOLS\Schedule_Editor.dll |
| Settings JSON | %APPDATA%\TIMCADTOOLS\CDD_Settings.json |
| Project Data | %APPDATA%\TIMCADTOOLS\CDD_ProjectData.json |
| DCL Fallback | C:\TIMCADTOOLS\CDD_DCL.dcl |

---

## REVISION HISTORY

| Date | Version | Changes |
|------|---------|---------|
| 2026-01-15 | 1.0 | Initial planning document |

---

*Document created by Claude Code during CDD v4.0 planning session*
