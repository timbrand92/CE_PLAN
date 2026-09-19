# CE_CVL_TOOLS - FULL C# .NET REWRITE PLAN
## Civil Stormwater Drainage Tools - Complete AutoCAD Plugin

**Created:** 2026-01-21
**Status:** PLANNING - AWAITING APPROVAL
**Based on:** CDD_v4_COMPLETE_SPECIFICATION.md, CDD_v4_PLANNING_DOCUMENT.md

---

## EXECUTIVE SUMMARY

This is a **FULL C# .NET REWRITE** of the CDD LISP system, including:

1. **CDD Command** - Complete rewrite in C# using AutoCAD .NET API
2. **PIT Command** - NEW command for placing stormwater pits
3. **PITSCHEDULE Command** - NEW spreadsheet editor for schedule management
4. **Modern WPF Dialogs** - Replace DCL with WPF
5. **Bug Fixes** - UCS support, Quick Mode, Text Masking
6. **JSON Settings** - Replace environment variables

---

## ARCHITECTURE OVERVIEW

### Technology Stack

| Component | Technology |
|-----------|------------|
| AutoCAD Integration | AutoCAD .NET API (AcMgd.dll, AcDbMgd.dll, AcCoreMgd.dll) |
| User Interface | WPF (Windows Presentation Foundation) |
| Data Storage | JSON (Newtonsoft.Json) |
| Target Framework | .NET Framework 4.8 (AutoCAD 2022+) |
| Target AutoCAD | AutoCAD 2022, 2023, 2024, 2025 |

### Single DLL Architecture

All commands in ONE DLL for easier deployment:

```
CE_CVL_TOOLS.dll
├── Commands/
│   ├── CddCommand.cs        [CommandMethod("CDD")]
│   ├── CddSettingsCommand.cs [CommandMethod("CDDS")]
│   ├── CddMoveArrowCommand.cs [CommandMethod("CDDA"), CommandMethod("MFA")]
│   ├── PitCommand.cs        [CommandMethod("PIT")]
│   └── PitScheduleCommand.cs [CommandMethod("PITSCHEDULE")]
├── Dialogs/
│   ├── CddDialog.xaml
│   ├── PitDialog.xaml
│   ├── ScheduleEditorDialog.xaml
│   └── AdvancedSettingsDialog.xaml
├── Services/
│   ├── LayerService.cs
│   ├── DrawingService.cs
│   ├── TextService.cs
│   ├── BlockService.cs
│   └── SettingsService.cs
└── Models/
    ├── PipeSettings.cs
    ├── PitData.cs
    └── ProjectData.cs
```

---

## PHASE 1: PROJECT SETUP & INFRASTRUCTURE

### 1.1 Visual Studio Solution Structure

```
c:\Lisp Files\CE_CVL_TOOLS\
├── CE_CVL_TOOLS.sln
├── CE_CVL_TOOLS\
│   ├── CE_CVL_TOOLS.csproj
│   │
│   ├── Commands\
│   │   ├── CddCommand.cs
│   │   ├── CddSettingsCommand.cs
│   │   ├── CddMoveArrowCommand.cs
│   │   ├── PitCommand.cs
│   │   └── PitScheduleCommand.cs
│   │
│   ├── Dialogs\
│   │   ├── CddDialog.xaml
│   │   ├── CddDialog.xaml.cs
│   │   ├── PitDialog.xaml
│   │   ├── PitDialog.xaml.cs
│   │   ├── ScheduleEditorDialog.xaml
│   │   ├── ScheduleEditorDialog.xaml.cs
│   │   ├── AdvancedSettingsDialog.xaml
│   │   └── AdvancedSettingsDialog.xaml.cs
│   │
│   ├── Controls\
│   │   ├── SearchableComboBox.xaml
│   │   ├── SearchableComboBox.xaml.cs
│   │   ├── ArrowPreviewControl.xaml
│   │   └── ArrowPreviewControl.xaml.cs
│   │
│   ├── ViewModels\
│   │   ├── CddViewModel.cs
│   │   ├── PitViewModel.cs
│   │   ├── ScheduleViewModel.cs
│   │   └── ViewModelBase.cs
│   │
│   ├── Models\
│   │   ├── PipeSettings.cs
│   │   ├── PipeType.cs
│   │   ├── GradeMethod.cs
│   │   ├── PitData.cs
│   │   ├── PipeData.cs
│   │   ├── ProjectData.cs
│   │   └── UserSettings.cs
│   │
│   ├── Services\
│   │   ├── LayerService.cs
│   │   ├── DrawingService.cs
│   │   ├── PolylineService.cs
│   │   ├── MlineService.cs
│   │   ├── TextService.cs
│   │   ├── BlockService.cs
│   │   ├── ArrowService.cs
│   │   ├── SettingsService.cs
│   │   ├── ProjectDataService.cs
│   │   └── UcsService.cs
│   │
│   ├── Helpers\
│   │   ├── GeometryHelper.cs
│   │   ├── MathHelper.cs
│   │   └── EditorHelper.cs
│   │
│   ├── Themes\
│   │   ├── LightTheme.xaml
│   │   └── DarkTheme.xaml
│   │
│   └── Properties\
│       └── AssemblyInfo.cs
│
└── packages.config (Newtonsoft.Json)
```

### 1.2 NuGet References

```xml
<packages>
  <package id="Newtonsoft.Json" version="13.0.3" />
</packages>
```

### 1.3 AutoCAD References

```
AcMgd.dll        - AutoCAD Managed Runtime
AcDbMgd.dll      - AutoCAD Database Managed
AcCoreMgd.dll    - AutoCAD Core Managed
(Copy Local = False for all)
```

---

## PHASE 2: CDD COMMAND - FULL IMPLEMENTATION

### 2.1 Command Registration

```csharp
[CommandMethod("CDD")]
public void CivilDrainageDesign()
{
    // 1. Show WPF dialog
    // 2. If OK, collect points from user
    // 3. Create pipe geometry (polyline + MLINE)
    // 4. Create text (pipe label, inverts)
    // 5. Insert arrow block
    // 6. Save to project data if schedule tracking enabled
}
```

### 2.2 CDD Dialog Design (from specification)

All sections visible - NO TABS:

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  CDD v4.0 - Civil Drainage Design                    [Theme]      [─][□][×]  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─ PIPE PROPERTIES ─────────────────┐  ┌─ PIPE TYPE ──────────────────────┐│
│  │  Diameter: [Searchable ▼] mm      │  │  ◉ Stormwater Pipe               ││
│  │  Material: [Searchable ▼]         │  │  ○ Charged Pipe    → [dest]      ││
│  │  ☐ Simple Pipe Only               │  │  ○ Suspended Pipe                ││
│  └───────────────────────────────────┘  │  ○ Rising Main     → [dest]      ││
│                                         │  ○ Detention Pipe                ││
│  ┌─ GRADE ───────────────────────────┐  └──────────────────────────────────┘│
│  │  ◉ Default (1 in 100 MIN.)        │                                      │
│  │  ○ Calculate from Inverts         │  ┌─ INVERTS ────────────────────────┐│
│  │  ○ Custom: [1 in ____]            │  │  ☑ First Point:  [1.10]          ││
│  └───────────────────────────────────┘  │  ☑ Second Point: [1.20]          ││
│                                         │  ☐ Mask invert text (MTEXT)      ││
│  ┌─ TEXT & ARROW ────────────────────┐  │  Recent: 1.10 | 1.05 | 0.95      ││
│  │  ☑ Create Pipe Text               │  └──────────────────────────────────┘│
│  │  ☑ Insert Flow Arrow              │                                      │
│  │  ☐ Reverse Arrow Direction        │  ┌─ QUICK MODE ─────────────────────┐│
│  └───────────────────────────────────┘  │  ☐ Auto-place ALL                ││
│                                         │  ☐ Auto-place Pipe Text only     ││
│  ┌─ SCHEDULE & BATCH ────────────────┐  │  ☐ Auto-place Inverts only       ││
│  │  ☑ Include in Pit Schedule        │  │  ☑ Auto-zoom to Pipe             ││
│  │  ☐ Enable Batch Mode              │  └──────────────────────────────────┘│
│  └───────────────────────────────────┘                                      │
│                                                                              │
│  ┌─ ARROW DIRECTION PREVIEW ─────────────────────────────────────────────┐  │
│  │     1.10m ════════════════►════════════════ 1.05m                     │  │
│  │     ✓ Flow: Left → Right (First Point higher)                         │  │
│  │     ✓ Grade: 1 in 200 (calculated from inverts)                       │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│  [⚙ Settings]                           [OK]    [Cancel]    [Reset]         │
└──────────────────────────────────────────────────────────────────────────────┘
```

### 2.3 Layer Definitions (from specification)

| Pipe Type | Polyline Layer | Color | MLINE Layer | Linetype |
|-----------|---------------|-------|-------------|----------|
| Stormwater Pipe | STORMWATER PIPE | 150 | DRAINAGE | DASHED |
| Charged Pipe | STORMWATER UPVC CHARGED PIPE | 10 | DRAINAGE | DASHED |
| Suspended Pipe | STORMWATER SUSPENDED PIPE | 211 | DRAINAGE HIDDEN | HIDDEN |
| Rising Main | STORMWATER RISING MAIN | 70 | DRAINAGE | DASHED |
| Detention Pipe | STORMWATER PIPE | 150 | DRAINAGE | DASHED |

Text Layers:
- `25TEXT` - Color 7 - Pipe text labels
- `20TEXT` - Color 10 - Invert text labels
- `ARROW` - Color 7 - Flow arrows

### 2.4 Text Settings (from specification)

| Setting | Value |
|---------|-------|
| Pipe Text Height | 250 |
| Invert Text Height | 180 |
| Line Spacing | 0.8 |
| Background Scale | 1.2 |
| Text Offset | 70 |
| Invert Inward Distance | 100 |

### 2.5 Pipe Drawing Logic

```csharp
public class DrawingService
{
    // Transform points from UCS to World (FIX for UCS bug)
    public Point3d TransformToWorld(Point3d ucsPoint)
    {
        var ucs = Application.DocumentManager.MdiActiveDocument.Editor.CurrentUserCoordinateSystem;
        return ucsPoint.TransformBy(ucs);
    }

    // Create polyline on pipe layer
    public ObjectId CreatePolyline(Point3dCollection points, string layerName)
    {
        // Use Database.AddNewlyCreatedDBObject
    }

    // Create MLINE on drainage layer
    public ObjectId CreateMline(Point3dCollection points, string layerName, double width)
    {
        // MLINE creation using MlineStyle
    }
}
```

### 2.6 Arrow Positioning (Bulletproof - from LISP)

```csharp
public class ArrowService
{
    // Arrow position = midpoint + (radius + 125) perpendicular BELOW the line
    public Point3d CalculateArrowPosition(Point3d pt1, Point3d pt2, double pipeWidth)
    {
        var midpoint = new Point3d(
            (pt1.X + pt2.X) / 2.0,
            (pt1.Y + pt2.Y) / 2.0,
            0);

        double radius = pipeWidth / 2.0;
        double offsetDistance = radius + 125.0;

        // Calculate perpendicular angle pointing DOWN
        double baseAngle = Math.Atan2(pt2.Y - pt1.Y, pt2.X - pt1.X);
        double perpAngle = baseAngle + Math.PI / 2;

        // Test if perpendicular points up - if so, flip it down
        var testPoint = new Point3d(
            midpoint.X + Math.Cos(perpAngle),
            midpoint.Y + Math.Sin(perpAngle),
            0);

        if (testPoint.Y > midpoint.Y)
            perpAngle += Math.PI;

        return new Point3d(
            midpoint.X + offsetDistance * Math.Cos(perpAngle),
            midpoint.Y + offsetDistance * Math.Sin(perpAngle),
            0);
    }

    // Calculate arrow rotation based on flow direction
    public double CalculateArrowRotation(Point3d pt1, Point3d pt2,
        string flowDirection, bool reverseArrow)
    {
        double baseRotation = Math.Atan2(pt2.Y - pt1.Y, pt2.X - pt1.X);

        // Adjust for flow direction
        if (flowDirection == "left-to-right")
            baseRotation += Math.PI; // Point opposite to drawing direction

        // Apply manual reversal
        if (reverseArrow)
            baseRotation += Math.PI;

        return baseRotation;
    }
}
```

### 2.7 Text Creation (FIX for masking bug)

```csharp
public class TextService
{
    // Create pipe text (MTEXT with background mask)
    public ObjectId CreatePipeText(Point3d position, string text, double angle)
    {
        using (var tr = db.TransactionManager.StartTransaction())
        {
            var mtext = new MText();
            mtext.Location = position;
            mtext.Contents = text;
            mtext.TextHeight = 250;
            mtext.Rotation = angle;
            mtext.Layer = "25TEXT";
            mtext.BackgroundFill = true;
            mtext.BackgroundScaleFactor = 1.2;
            // Add to modelspace
        }
    }

    // Create invert text - REGULAR TEXT (no mask)
    public ObjectId CreateInvertTextRegular(Point3d position, string text, double angle)
    {
        using (var tr = db.TransactionManager.StartTransaction())
        {
            var dbText = new DBText();
            dbText.Position = position;
            dbText.TextString = text;
            dbText.Height = 180;
            dbText.Rotation = angle;
            dbText.Layer = "20TEXT";
            dbText.HorizontalMode = TextHorizontalMode.TextCenter;
            dbText.VerticalMode = TextVerticalMode.TextVerticalMid;
            dbText.AlignmentPoint = position;
            // Add to modelspace
        }
    }

    // Create invert text - MASKED MTEXT
    public ObjectId CreateInvertTextMasked(Point3d position, string text,
        double angle, double pipeAngle)
    {
        // Move text INWARD from endpoint by 100 units
        double inwardDistance = 100;
        var adjustedPosition = new Point3d(
            position.X - inwardDistance * Math.Cos(pipeAngle),
            position.Y - inwardDistance * Math.Sin(pipeAngle),
            0);

        using (var tr = db.TransactionManager.StartTransaction())
        {
            var mtext = new MText();
            mtext.Location = adjustedPosition;
            mtext.Contents = text;
            mtext.TextHeight = 180;
            mtext.Rotation = angle;
            mtext.Layer = "20TEXT";
            mtext.Attachment = AttachmentPoint.MiddleCenter;
            mtext.BackgroundFill = true;
            mtext.BackgroundScaleFactor = 1.2;
            // Add to modelspace
        }
    }
}
```

### 2.8 Quick Mode Auto-Placement (FIX for positioning bug)

```csharp
public class QuickModeService
{
    // Calculate text position ABOVE pipe
    public Point3d CalculatePipeTextPosition(Point3d pt1, Point3d pt2, double pipeWidth)
    {
        var midpoint = GetMidpoint(pt1, pt2);
        double offset = pipeWidth / 2.0 + 125.0;
        double perpAngle = CalculatePerpendicularAngle(pt1, pt2, "up");
        return Polar(midpoint, perpAngle, offset);
    }

    // Calculate invert position at endpoint
    public Point3d CalculateInvertPosition(Point3d endpoint,
        double pipeAngle, string side)
    {
        double offset = 100;
        double perpAngle = side == "left"
            ? pipeAngle + Math.PI / 2
            : pipeAngle - Math.PI / 2;

        // Normalize angle to 0-2π
        while (perpAngle < 0) perpAngle += 2 * Math.PI;
        while (perpAngle >= 2 * Math.PI) perpAngle -= 2 * Math.PI;

        return Polar(endpoint, perpAngle, offset);
    }
}
```

---

## PHASE 3: PIT COMMAND - NEW FEATURE

### 3.1 PIT Dialog Design (from specification)

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  Place Stormwater Pit                                [Theme]      [─][□][×]  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─ PIT DETAILS ─────────────────────────────────────────────────────────┐  │
│  │  Pit Number:    [P1        ] [Auto ▼]                                 │  │
│  │  Pit Type:      [GRATED PIT                          ▼]               │  │
│  │  X Width:       [450      ] mm    Y Width: [450      ] mm             │  │
│  │  SPS Radius:    [900      ] mm    (only for SPS types)                │  │
│  │  Cover Level:   [13.75    ] m AHD                                     │  │
│  │  Text Above CL: [                                    ]                │  │
│  │  Text Below CL: [                                    ]                │  │
│  │  Lid Type:      [Class A Grate                       ▼]               │  │
│  │  Remarks:       [Silt Pit                            ]                │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  ┌─ OPTIONS ─────────────────────────────────────────────────────────────┐  │
│  │  ☑ Add pit label block                                                │  │
│  │  ☑ Add cover level text                                               │  │
│  │  ☑ Include in schedule                                                │  │
│  │  ☐ Plastic pit (PP) - NO label block, NOT in schedule                 │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  ┌─ INVERT LEVEL (Optional) ─────────────────────────────────────────────┐  │
│  │  ☐ Show pit invert level: [13.45    ] m AHD                           │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  ┌─ TEXT POSITION PREVIEW ───────────────────────────────────────────────┐  │
│  │         ○ TL                              TR ○                        │  │
│  │                  ┌─────────────┐                                      │  │
│  │                  │     PIT     │                                      │  │
│  │                  └─────────────┘                                      │  │
│  │         ○ BL                              BR ◉                        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│                          [Place Pit]           [Cancel]                      │
└──────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Pit Block Properties

Dynamic block with visibility parameter `PIT_TYPE`:
- GRATED PIT (X_WIDTH, Y_WIDTH)
- SOLID PIT (X_WIDTH, Y_WIDTH)
- SPS GRATED PIT (X_WIDTH, Y_WIDTH, SPS_RADIUS)
- SPS SOLID PIT (SPS_RADIUS)
- DETENTION PIT (X_WIDTH_DETENTION_SOLID, X_WIDTH_DETENTION_GRATED, Y_WIDTH_DETENTION)

### 3.3 Cover Level Text Positioning

MTEXT at corner of pit (200 units offset from pit edge):

| Position | Rotation | Justification |
|----------|----------|---------------|
| Top Left (NW) | 315° | Middle Right |
| Top Right (NE) | 45° | Middle Left |
| Bottom Left (SW) | 45° | Middle Right |
| Bottom Right (SE) | 315° | Middle Left |

---

## PHASE 4: PITSCHEDULE COMMAND - NEW FEATURE

### 4.1 Schedule Editor Dialog

Spreadsheet-style editor with columns:
- PIT No.
- PIT SIZE
- FROM (Inlet)
- DIA (Inlet)
- INVERT LEVEL (Inlet)
- DIA (Outlet)
- INVERT LEVEL (Outlet)
- COVER
- DEPTH (auto-calculated)
- LID TYPE
- REMARKS

### 4.2 Features
- Add/Delete/Move rows
- Refresh from drawing
- Import/Export CSV
- Place text in schedule block
- Auto-calculate depth (Cover - Outlet IL)
- Warning highlight for shallow pits (< 0.30m)

---

## PHASE 5: SETTINGS & DATA STORAGE

### 5.1 User Settings JSON

Location: `%APPDATA%\TIM_CE_CADTOOLS\CDD_Settings.json`

```json
{
  "version": "4.0",
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
    "recentValues": ["1.10", "1.05", "0.95"]
  },
  "grade": {
    "method": "default",
    "customValue": ""
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
  "theme": "auto"
}
```

### 5.2 Project Data JSON

Location: `%APPDATA%\TIM_CE_CADTOOLS\CDD_ProjectData.json`

```json
{
  "drawingPath": "C:\\Projects\\Drainage.dwg",
  "pits": [
    {
      "id": "P1",
      "size": "450x450 Grated Pit",
      "coverLevel": "13.75",
      "position": [12500.0, 8750.0],
      "entityHandle": "ABC123"
    }
  ],
  "pipes": [
    {
      "id": "PIPE_001",
      "from": "DP",
      "to": "P1",
      "diameter": "100",
      "fromInvert": "13.70",
      "toInvert": "13.60",
      "entityHandle": "DEF123"
    }
  ]
}
```

---

## PHASE 6: DEPLOYMENT

### 6.1 Build Output

```
C:\TIMCADTOOLS\
├── CE_CVL_TOOLS.dll          ← Main plugin DLL
├── Newtonsoft.Json.dll       ← JSON library
└── Blocks\
    ├── TIM_CVL_ARROW.dwg     ← Arrow block
    ├── PIT BLOCK.dwg         ← Pit block
    ├── PIT LABEL.dwg         ← Pit label block
    └── Pit Schedule.dwg      ← Schedule template
```

### 6.2 AutoCAD Loading

Add to `acad.lsp` or `acaddoc.lsp`:
```lisp
(command "_.NETLOAD" "C:/TIMCADTOOLS/CE_CVL_TOOLS.dll")
```

Or use bundle deployment with `PackageContents.xml`.

---

## IMPLEMENTATION ORDER

### Week 1: Foundation
1. Create Visual Studio solution and project structure
2. Add AutoCAD references and NuGet packages
3. Create base classes (ViewModelBase, Services)
4. Implement SettingsService (JSON load/save)
5. Create LayerService

### Week 2: CDD Dialog & Basic Drawing
6. Build CddDialog.xaml (all sections)
7. Implement CddViewModel with data binding
8. Create SearchableComboBox control
9. Implement DrawingService (polyline creation)
10. Implement basic CDD command flow

### Week 3: CDD Complete
11. Implement MlineService
12. Implement TextService (pipe text, inverts)
13. Implement ArrowService (bulletproof positioning)
14. Implement QuickModeService
15. Add UCS transformation support

### Week 4: PIT Command
16. Build PitDialog.xaml
17. Implement PitViewModel
18. Implement BlockService (dynamic block insertion)
19. Implement pit cover level text positioning
20. Implement ProjectDataService

### Week 5: PITSCHEDULE & Testing
21. Build ScheduleEditorDialog.xaml
22. Implement ScheduleViewModel with DataGrid
23. Implement CSV import/export
24. Implement schedule block text placement
25. Full testing and bug fixes

---

## KEY BEHAVIORAL REQUIREMENTS

The C# implementation MUST match the LISP behavior exactly for:

1. **Layer creation** - Same names, colors, linetypes
2. **Arrow positioning** - Exactly radius + 125 units below midpoint
3. **Text positioning** - Same offsets and justifications
4. **Flow direction** - Water flows HIGH to LOW
5. **Grade calculation** - Distance / (FirstInvert - SecondInvert)
6. **Quick Mode** - Same auto-placement logic
7. **Invert masking** - Same inward distance (100 units)

---

## TESTING CHECKLIST

### CDD Command
- [ ] All 5 pipe types create correct layers
- [ ] Polyline and MLINE created correctly
- [ ] Arrow at correct position and rotation
- [ ] Pipe text at correct position
- [ ] Invert text (regular and masked) correct
- [ ] Quick Mode ALL works in all directions
- [ ] Batch Mode repeats correctly
- [ ] UCS transformation works
- [ ] Settings save and load

### PIT Command
- [ ] All 5 pit types insert correctly
- [ ] Dynamic properties set correctly
- [ ] Cover level text at correct corner
- [ ] Pit label block inserted
- [ ] Data saved to project JSON

### PITSCHEDULE Command
- [ ] Data loads from project JSON
- [ ] Grid is editable
- [ ] Add/Delete/Move rows work
- [ ] CSV import/export work
- [ ] Schedule block text placement works

---

## READY FOR APPROVAL

This plan covers:
- ✅ Full C# rewrite of CDD command
- ✅ New PIT command
- ✅ New PITSCHEDULE command
- ✅ Modern WPF dialogs
- ✅ All bug fixes (UCS, Quick Mode, Text Masking)
- ✅ JSON settings system
- ✅ Same behavior as existing LISP

**Proceed with implementation?**
