# CE_CVL_PIPE Custom Entity - ObjectARX Implementation Plan

## Project Overview

**Goal:** Create a custom AutoCAD entity called `PIPE` that combines the visual appearance of a polyline (with width) and MLINE (border) into a single selectable entity with custom properties.

**Location:** `c:\Lisp Files\CE_CVL_PIPE_ENTITY\`

**Target AutoCAD Versions:** 2022, 2023, 2024, 2025

---

## Why Custom Entity?

Currently, the CD command creates **two separate entities**:
1. **Polyline** - Width = diameter, DASHED linetype, colored by layer (150 for stormwater)
2. **MLINE** - Scale = diameter, magenta color (6), acts as outer border

**Problems with current approach:**
- Two entities to select/move/copy
- Can become misaligned
- Complex selection sets
- No unified properties panel

**Custom PIPE entity solves this:**
- Single entity selection
- Unified properties (diameter, material, type)
- Consistent move/copy/mirror behavior
- Custom property panel in AutoCAD

---

## Visual Specification

```
PIPE CROSS-SECTION VIEW:
┌─────────────────────────────────────────────────────────────┐
│  ══════════════════════════════════════════════════════════  │  ← Top border (magenta, color 6)
│  │ - - - - - - - - - - - - - - - - - - - - - - - - - - - │  │  ← Internal fill (layer color, DASHED)
│  ══════════════════════════════════════════════════════════  │  ← Bottom border (magenta, color 6)
└─────────────────────────────────────────────────────────────┘

VISUAL ELEMENTS:
1. OUTER BORDER (top & bottom lines)
   - Color: 6 (magenta) - ALWAYS
   - Lineweight: 0.25mm
   - Linetype: CONTINUOUS

2. INTERNAL FILL (the "pipe body")
   - Color: From layer (e.g., 150 for stormwater)
   - Linetype: DASHED (center line effect)
   - Fill: Solid with layer color

3. ENDPOINTS
   - Rounded caps matching current polyline behavior
```

---

## Custom Properties

| Property | Type | Description | Example |
|----------|------|-------------|---------|
| `StartPoint` | Point3d | First endpoint | (1000, 2000, 0) |
| `EndPoint` | Point3d | Second endpoint | (5000, 2000, 0) |
| `Diameter` | double | Pipe diameter in mm | 100.0 |
| `Material` | string | Pipe material | "UPVC", "RCP / RRJ" |
| `PipeType` | int | Type enum value | 0=Storm, 1=Charged, etc. |
| `OutlineColor` | short | Border color (ACI) | 6 (magenta) |
| `FillColor` | short | Internal color (ACI) | 150 |
| `Linetype` | string | Internal linetype | "DASHED" |
| `Grade` | string | Grade string | "1 IN 100" |
| `FirstInvert` | double | First invert level | 1.10 |
| `SecondInvert` | double | Second invert level | 1.05 |

---

## Project Architecture

```
c:\Lisp Files\CE_CVL_PIPE_ENTITY\
│
├── CE_CVL_PIPE_ENTITY.sln              (Visual Studio Solution)
│
├── PipeDbx\                             (C++ Custom Entity Definition)
│   ├── PipeDbx.vcxproj
│   ├── PipeEntity.h                     (Entity class declaration)
│   ├── PipeEntity.cpp                   (Entity implementation)
│   ├── PipeEntityReactor.cpp            (Optional: reactors)
│   ├── StdAfx.h
│   ├── main.cpp                         (DLL entry point)
│   └── PipeDbx.def                      (Export definitions)
│   → OUTPUT: PipeDbx.dbx
│
├── PipeArx\                             (C++ Command Registration)
│   ├── PipeArx.vcxproj
│   ├── PipeCommands.cpp                 (CREATEPIPE, EDITPIPE commands)
│   ├── StdAfx.h
│   └── main.cpp
│   → OUTPUT: PipeArx.arx
│
├── PipeManagedWrapper\                  (C++/CLI .NET Bridge)
│   ├── PipeManagedWrapper.vcxproj
│   ├── PipeEntityMgd.h                  (Managed wrapper declaration)
│   ├── PipeEntityMgd.cpp                (Managed wrapper implementation)
│   └── AssemblyInfo.cpp
│   → OUTPUT: PipeManagedWrapper.dll
│
├── objectarx.props                      (ObjectARX SDK paths)
├── README.md
└── BUILDING.md                          (Build instructions)
```

---

## C++ Entity Class Design

### PipeEntity.h

```cpp
#pragma once

#include "dbmain.h"
#include "geassign.h"
#include "gepnt3d.h"
#include "gevec3d.h"

// Forward declare for ACRX class factory
#define ASDKPIPEENTITY_DBXSERVICE "ASDKPIPEENTITY_DBXSERVICE"

class AsdkPipeEntity : public AcDbEntity
{
public:
    ACRX_DECLARE_MEMBERS(AsdkPipeEntity);

    // Constructors
    AsdkPipeEntity();
    AsdkPipeEntity(const AcGePoint3d& startPt, const AcGePoint3d& endPt, double diameter);
    virtual ~AsdkPipeEntity();

    // ===== CUSTOM PROPERTIES =====

    // Start/End Points
    AcGePoint3d startPoint() const;
    Acad::ErrorStatus setStartPoint(const AcGePoint3d& pt);

    AcGePoint3d endPoint() const;
    Acad::ErrorStatus setEndPoint(const AcGePoint3d& pt);

    // Diameter
    double diameter() const;
    Acad::ErrorStatus setDiameter(double d);

    // Material
    const ACHAR* material() const;
    Acad::ErrorStatus setMaterial(const ACHAR* mat);

    // Pipe Type (0=Storm, 1=Charged, 2=Suspended, 3=Rising, 4=Detention)
    Adesk::Int16 pipeType() const;
    Acad::ErrorStatus setPipeType(Adesk::Int16 type);

    // Colors
    Adesk::Int16 outlineColor() const;
    Acad::ErrorStatus setOutlineColor(Adesk::Int16 color);

    Adesk::Int16 fillColor() const;
    Acad::ErrorStatus setFillColor(Adesk::Int16 color);

    // Inverts
    double firstInvert() const;
    Acad::ErrorStatus setFirstInvert(double inv);

    double secondInvert() const;
    Acad::ErrorStatus setSecondInvert(double inv);

    // Grade
    const ACHAR* grade() const;
    Acad::ErrorStatus setGrade(const ACHAR* g);

    // ===== CALCULATED PROPERTIES =====
    double length() const;
    AcGePoint3d midpoint() const;
    double angle() const;

    // ===== AcDbEntity OVERRIDES =====

    // Drawing
    virtual Adesk::Boolean worldDraw(AcGiWorldDraw* mode) override;
    virtual void viewportDraw(AcGiViewportDraw* mode) override;

    // DWG Filing (save/load)
    virtual Acad::ErrorStatus dwgInFields(AcDbDwgFiler* filer) override;
    virtual Acad::ErrorStatus dwgOutFields(AcDbDwgFiler* filer) const override;

    // DXF Filing
    virtual Acad::ErrorStatus dxfInFields(AcDbDxfFiler* filer) override;
    virtual Acad::ErrorStatus dxfOutFields(AcDbDxfFiler* filer) const override;

    // Transformation
    virtual Acad::ErrorStatus transformBy(const AcGeMatrix3d& xform) override;

    // Geometry
    virtual Acad::ErrorStatus getGeomExtents(AcDbExtents& extents) const override;

    // Grips
    virtual Acad::ErrorStatus getGripPoints(
        AcGePoint3dArray& gripPoints,
        AcDbIntArray& osnapModes,
        AcDbIntArray& geomIds) const override;

    virtual Acad::ErrorStatus moveGripPointsAt(
        const AcDbIntArray& indices,
        const AcGeVector3d& offset) override;

    // Object Snaps
    virtual Acad::ErrorStatus getOsnapPoints(
        AcDb::OsnapMode osnapMode,
        Adesk::GsMarker gsSelectionMark,
        const AcGePoint3d& pickPoint,
        const AcGePoint3d& lastPoint,
        const AcGeMatrix3d& viewXform,
        AcGePoint3dArray& snapPoints,
        AcDbIntArray& geomIds) const override;

    // Explode
    virtual Acad::ErrorStatus explode(AcDbVoidPtrArray& entitySet) const override;

    // Subentity (for highlighting)
    virtual Acad::ErrorStatus subGetSubentPathsAtGsMarker(
        AcDb::SubentType type,
        Adesk::GsMarker gsMark,
        const AcGePoint3d& pickPoint,
        const AcGeMatrix3d& viewXform,
        int& numPaths,
        AcDbFullSubentPath*& subentPaths,
        int numInserts = 0,
        AcDbObjectId* entAndInsertStack = nullptr) const override;

private:
    // Data members
    AcGePoint3d m_startPoint;
    AcGePoint3d m_endPoint;
    double m_diameter;
    AcString m_material;
    Adesk::Int16 m_pipeType;
    Adesk::Int16 m_outlineColor;
    Adesk::Int16 m_fillColor;
    double m_firstInvert;
    double m_secondInvert;
    AcString m_grade;

    // Helper methods
    void drawOutline(AcGiWorldDraw* mode) const;
    void drawFill(AcGiWorldDraw* mode) const;
    void calculateCorners(AcGePoint3d corners[4]) const;

    // Version for filing
    static const Adesk::Int16 kCurrentVersionNumber;
};
```

### PipeEntity.cpp - worldDraw Implementation

```cpp
Adesk::Boolean AsdkPipeEntity::worldDraw(AcGiWorldDraw* mode)
{
    assertReadEnabled();

    // Calculate the four corners of the pipe rectangle
    AcGePoint3d corners[4];
    calculateCorners(corners);

    // ===== 1. DRAW OUTER BORDER (magenta) =====
    mode->subEntityTraits().setColor(m_outlineColor);  // 6 = magenta
    mode->subEntityTraits().setLineWeight(AcDb::kLnWt025);
    mode->subEntityTraits().setLinetype(acdbHostApplicationServices()->workingDatabase()->continuousLinetype());

    // Top border line
    AcGePoint3d topLine[2] = { corners[0], corners[3] };
    mode->geometry().polyline(2, topLine);

    // Bottom border line
    AcGePoint3d bottomLine[2] = { corners[1], corners[2] };
    mode->geometry().polyline(2, bottomLine);

    // End caps (left and right)
    AcGePoint3d leftCap[2] = { corners[0], corners[1] };
    mode->geometry().polyline(2, leftCap);

    AcGePoint3d rightCap[2] = { corners[3], corners[2] };
    mode->geometry().polyline(2, rightCap);

    // ===== 2. DRAW INTERNAL FILL (layer color, dashed) =====
    mode->subEntityTraits().setColor(m_fillColor);  // From layer
    mode->subEntityTraits().setFillType(kAcGiFillAlways);

    // Fill the rectangle
    mode->geometry().polygon(4, corners);

    // ===== 3. DRAW CENTER DASHED LINE =====
    // Get DASHED linetype
    AcDbObjectId dashedLtId = AcDbObjectId::kNull;
    AcDbLinetypeTable* pLtTable;
    if (acdbHostApplicationServices()->workingDatabase()->getLinetypeTable(pLtTable, AcDb::kForRead) == Acad::eOk)
    {
        pLtTable->getAt(_T("DASHED"), dashedLtId);
        pLtTable->close();
    }

    if (!dashedLtId.isNull())
    {
        mode->subEntityTraits().setLinetype(dashedLtId);
    }

    mode->subEntityTraits().setColor(m_fillColor);
    AcGePoint3d centerLine[2] = { m_startPoint, m_endPoint };
    mode->geometry().polyline(2, centerLine);

    return Adesk::kTrue;
}

void AsdkPipeEntity::calculateCorners(AcGePoint3d corners[4]) const
{
    // Calculate perpendicular direction
    AcGeVector3d direction = m_endPoint - m_startPoint;
    direction.normalize();

    AcGeVector3d perpendicular = direction.perpVector();
    perpendicular.normalize();

    double radius = m_diameter / 2.0;

    // corners[0] = start point + perpendicular (top-left)
    // corners[1] = start point - perpendicular (bottom-left)
    // corners[2] = end point - perpendicular (bottom-right)
    // corners[3] = end point + perpendicular (top-right)

    corners[0] = m_startPoint + perpendicular * radius;
    corners[1] = m_startPoint - perpendicular * radius;
    corners[2] = m_endPoint - perpendicular * radius;
    corners[3] = m_endPoint + perpendicular * radius;
}
```

---

## C++/CLI Managed Wrapper Design

### PipeEntityMgd.h

```cpp
#pragma once

using namespace System;
using namespace Autodesk::AutoCAD::Geometry;
using namespace Autodesk::AutoCAD::DatabaseServices;
using namespace Autodesk::AutoCAD::Runtime;

namespace CE_CVL_PIPE
{
    [Wrapper("AsdkPipeEntity")]
    public ref class PipeEntity : public Autodesk::AutoCAD::DatabaseServices::Entity
    {
    public:
        PipeEntity();
        PipeEntity(Point3d startPoint, Point3d endPoint, double diameter);

        // Properties
        property Point3d StartPoint
        {
            Point3d get();
            void set(Point3d value);
        }

        property Point3d EndPoint
        {
            Point3d get();
            void set(Point3d value);
        }

        property double Diameter
        {
            double get();
            void set(double value);
        }

        property String^ Material
        {
            String^ get();
            void set(String^ value);
        }

        property int PipeType
        {
            int get();
            void set(int value);
        }

        property int OutlineColor
        {
            int get();
            void set(int value);
        }

        property int FillColor
        {
            int get();
            void set(int value);
        }

        property double FirstInvert
        {
            double get();
            void set(double value);
        }

        property double SecondInvert
        {
            double get();
            void set(double value);
        }

        property String^ Grade
        {
            String^ get();
            void set(String^ value);
        }

        // Calculated properties
        property double Length { double get(); }
        property Point3d Midpoint { Point3d get(); }
        property double Angle { double get(); }

    internal:
        AsdkPipeEntity* GetImpObj();
    };
}
```

---

## Integration with CE_CVL_TOOLS

After building the custom entity, update CE_CVL_TOOLS to use it:

### Updated CdCommand.cs

```csharp
using CE_CVL_PIPE;  // Reference the managed wrapper

// In ExecutePipeDrawing method:
private bool ExecutePipeDrawing(CdViewModel vm, Editor ed)
{
    // Get two points from user
    if (!DrawingService.GetTwoPoints(out Point3d pt1, out Point3d pt2))
        return false;

    double diameter = double.Parse(vm.SelectedDiameter);

    // CREATE SINGLE PIPE ENTITY (instead of polyline + MLINE)
    using (Transaction tr = db.TransactionManager.StartTransaction())
    {
        BlockTableRecord btr = /* get model space */;

        // Create the custom pipe entity
        var pipe = new PipeEntity(pt1, pt2, diameter);
        pipe.Material = vm.SelectedMaterial;
        pipe.PipeType = (int)GetPipeType(vm);
        pipe.OutlineColor = 6;  // Magenta border
        pipe.FillColor = GetLayerColor(vm);  // From layer definition

        if (vm.FirstInvertEnabled)
            pipe.FirstInvert = double.Parse(vm.FirstInvert);
        if (vm.SecondInvertEnabled)
            pipe.SecondInvert = double.Parse(vm.SecondInvert);

        pipe.Grade = CalculateGrade(vm, distance);

        btr.AppendEntity(pipe);
        tr.AddNewlyCreatedDBObject(pipe, true);
        tr.Commit();
    }

    ed.WriteMessage($"\nCreated PIPE entity: {diameter} DIA. {vm.SelectedMaterial}");
    // ... rest of the command (text, inverts, arrow)
}
```

---

## Build Requirements

### Software Required

| Item | Version | Notes |
|------|---------|-------|
| Visual Studio 2022 | 17.x | With C++ Desktop Development workload |
| ObjectARX SDK | 2022/2023/2024 | Download from Autodesk |
| .NET SDK | 4.8 or 8.0 | For managed wrapper |
| AutoCAD | 2022+ | For testing |

### ObjectARX SDK Download

1. Go to: https://aps.autodesk.com/developer/overview/objectarx-autocad-sdk
2. Accept license agreement
3. Download SDK for your target AutoCAD version
4. Extract to: `C:\ObjectARX\2022\` (or version-specific folder)

### Visual Studio Workloads

Install via Visual Studio Installer:
- Desktop development with C++
- .NET desktop development
- C++/CLI support (under Individual Components)

---

## Build Steps

### 1. Configure ObjectARX Paths

Create `objectarx.props` in solution folder:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup Label="UserMacros">
    <ARXSDK>C:\ObjectARX\2022</ARXSDK>
  </PropertyGroup>
  <PropertyGroup>
    <IncludePath>$(ARXSDK)\inc;$(IncludePath)</IncludePath>
    <LibraryPath>$(ARXSDK)\lib\x64;$(LibraryPath)</LibraryPath>
  </PropertyGroup>
</Project>
```

### 2. Build Order

1. **PipeDbx** (C++ DBX) - Creates entity definition
2. **PipeArx** (C++ ARX) - Creates commands
3. **PipeManagedWrapper** (C++/CLI) - Creates .NET wrapper
4. **CE_CVL_TOOLS** (C#) - Uses the wrapper

### 3. Load Order in AutoCAD

```
Command: APPLOAD
1. PipeDbx.dbx       (registers entity class)
2. PipeArx.arx       (registers commands)

Command: NETLOAD
3. PipeManagedWrapper.dll  (managed wrapper)
4. CE_CVL_TOOLS.dll        (your main plugin)
```

---

## Object Enabler Distribution

**CRITICAL:** Anyone opening a DWG with your custom PIPE entities needs the Object Enabler installed!

### What to Distribute

```
CE_CVL_PIPE_ObjectEnabler\
├── PipeDbx.dbx              (Entity definition)
├── Install.bat              (Copies to ApplicationPlugins)
├── Uninstall.bat
└── README.txt
```

### Install Location

```
%PROGRAMFILES%\Autodesk\ApplicationPlugins\CE_CVL_PIPE.bundle\
└── Contents\
    └── PipeDbx.dbx
```

### PackageContents.xml for Object Enabler

```xml
<?xml version="1.0" encoding="utf-8"?>
<ApplicationPackage
    SchemaVersion="1.0"
    ProductCode="{GENERATE-NEW-GUID}"
    Name="CE_CVL_PIPE_ObjectEnabler"
    Description="Object Enabler for CE CVL PIPE custom entities"
    AppVersion="1.0.0"
    Author="Creative Engineering">

    <CompanyDetails Name="Creative Engineering" />

    <Components>
        <RuntimeRequirements OS="Win64" Platform="AutoCAD" SeriesMin="R24.0" />
        <ComponentEntry
            ModuleName="./Contents/PipeDbx.dbx"
            AppDescription="CE CVL PIPE Entity"
            LoadOnAutoCADStartup="True" />
    </Components>
</ApplicationPackage>
```

---

## Testing Checklist

### Entity Creation
- [ ] PIPE entity created with correct diameter
- [ ] Start/End points stored correctly
- [ ] All properties saved to entity

### Visual Appearance
- [ ] Outer border is magenta (color 6)
- [ ] Inner fill matches layer color
- [ ] Center line shows DASHED linetype
- [ ] Width matches diameter

### Entity Behavior
- [ ] Single click selects entire entity
- [ ] MOVE command works
- [ ] COPY command works
- [ ] MIRROR command works
- [ ] ROTATE command works
- [ ] SCALE command works

### Grips
- [ ] Grip at start point
- [ ] Grip at end point
- [ ] Grip at midpoint (optional)
- [ ] Grips stretch correctly

### Object Snaps
- [ ] ENDPOINT snap works
- [ ] MIDPOINT snap works
- [ ] NEAREST snap works
- [ ] PERPENDICULAR snap works

### File Operations
- [ ] Save to DWG works
- [ ] Open from DWG works
- [ ] WBLOCK works
- [ ] INSERT works

### Object Enabler
- [ ] DWG opens on machine without full plugin
- [ ] Entity displays correctly with just Object Enabler
- [ ] No proxy entity warnings

### Properties Panel
- [ ] All custom properties show in Properties palette
- [ ] Properties are editable
- [ ] Changes update entity display

---

## Estimated Development Time

| Phase | Task | Hours |
|-------|------|-------|
| 1 | Setup VS projects, ObjectARX SDK | 4-8 |
| 2 | Implement AsdkPipeEntity class | 16-24 |
| 3 | Implement worldDraw (visual) | 8-12 |
| 4 | Implement DWG filing | 4-8 |
| 5 | Implement grips | 4-8 |
| 6 | Implement object snaps | 4-8 |
| 7 | Implement transformBy | 2-4 |
| 8 | Implement explode | 2-4 |
| 9 | Create C++/CLI wrapper | 8-12 |
| 10 | Integrate with CE_CVL_TOOLS | 4-8 |
| 11 | Testing and debugging | 16-24 |
| 12 | Object Enabler packaging | 4-8 |
| **TOTAL** | | **76-128 hours** |

---

## Alternative: Phased Approach

If full custom entity is too complex, consider a phased approach:

### Phase 1: Group-based (Quick Win)
- Create polyline + MLINE as before
- Use AutoCAD GROUP to link them
- Store XData on the polyline
- ~4 hours implementation

### Phase 2: DrawableOverrule (Medium)
- Use polyline as base entity
- Override WorldDraw to add MLINE appearance
- Store data in XData
- ~16-24 hours implementation

### Phase 3: Full Custom Entity (Complete)
- Full ObjectARX implementation as described above
- ~76-128 hours implementation

---

## Resources

### Official Documentation
- ObjectARX SDK Help: `%ARXSDK%\docs\arxref.chm`
- AutoCAD Developer Help: https://help.autodesk.com/view/OARX/2024/ENU/

### Sample Code
- ObjectARX SDK Samples: `%ARXSDK%\samples\`
- AsdkPoly sample: https://github.com/MadhukarMoogala/adskpoly
- ManagedCircle sample: https://github.com/MadhukarMoogala/ManagedCircle

### Blogs
- Through the Interface: https://www.keanw.com/custom_objects/
- AutoCAD DevBlog: https://adndevblog.typepad.com/autocad/objectarx/

---

## Document Version

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-22 | Claude | Initial plan document |

---

## Approval

**Status:** PLANNING - Ready for review

**Next Steps:**
1. Review this plan document
2. Download and install ObjectARX SDK
3. Create Visual Studio solution
4. Begin implementation

---

## Quick Start Command (New Chat)

When starting a new chat to implement this, use:

```
I need to create a custom AutoCAD entity called PIPE using ObjectARX (C++).
The plan document is at: c:\Lisp Files\CE_CVL_PIPE_ENTITY_PLAN.md
Please read it and begin implementation.
```
