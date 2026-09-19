"""Planning-only, read-only shared UI inventory across two identified source copies."""
from pathlib import Path
import json, hashlib, re
from datetime import datetime, timezone

out=Path(__file__).parent
roots={'baseline':Path(r'C:\Lisp Files\CE_ACAD_PLUGIN'),
       'shared-owner':Path(r'C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN')}
groups={
 '02_SHARED_JOB_AND_ISSUE.md':[
 'Modules/Structural/UI/Dialogs/CeProjectSetupDialog.xaml','Modules/Structural/UI/Dialogs/CeSheetsWindow.xaml',
 'Modules/Structural/UI/Dialogs/CeSheetsManagerWindow.xaml','Modules/Structural/UI/Dialogs/CeSheetsSyncPreviewWindow.xaml',
 'Modules/Structural/UI/Dialogs/CeSheetsValidationReportWindow.xaml','Modules/Structural/UI/Dialogs/CeSharedTitleMappingWindow.xaml',
 'Modules/Structural/UI/Dialogs/CePropsDialog.xaml','Modules/Structural/UI/Dialogs/CeIssuePublishDialog.xaml',
 'Modules/Structural/UI/Dialogs/CeSheetsIssueReviewDialog.xaml','Modules/Structural/UI/Pages/CeProjectSheetsWorkspaceView.xaml',
 'Modules/Manager/UI/Pages/ProjectSheetsWorkspacePage.xaml'],
 '03_SETTINGS_ASSETS_AND_HELP.md':[
 'Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml','Modules/Structural/UI/Dialogs/SettingsDialog.xaml',
 'Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml','Modules/Drainage/Dialogs/OsnapSettingsDialog.xaml',
 'Modules/Drainage/Dialogs/CivilSettingsView.xaml','Modules/Drainage/Dialogs/CivilGeneralSettingsView.xaml',
 'Modules/Drainage/Dialogs/CivilHelpGuideView.xaml','Modules/Drainage/Dialogs/HelpGuideWindow.xaml',
 'Modules/Drainage/Dialogs/CdHelpDialog.xaml','Modules/Manager/UI/Pages/SettingsWorkspacePage.xaml',
 'Modules/Manager/UI/Pages/HelpWorkspacePage.xaml'],
 '04_PRODUCT_SUPPORT_AND_ASSISTANCE.md':[
 'Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml','Modules/Manager/UI/Dialogs/PluginAdminWindow.xaml',
 'Modules/Drainage/Dialogs/FeedbackDialog.xaml','Modules/Drainage/Dialogs/WhatsNewDialog.xaml',
 'Modules/Drainage/Controls/CeAssistantControl.xaml','Modules/Structural/UI/Palette/MarkupAIPanel.xaml'],
 '05_CROSS_DISCIPLINE_CHANGE_CONTRACT.md':[
 'Modules/Manager/UI/Pages/ProjectQaPage.xaml','Modules/Manager/UI/Pages/DrawingRepairPage.xaml']}
rows=[];missing=[]
pattern=re.compile(r'<(?:\w+:)?(Button|ToggleButton|CheckBox|RadioButton|TabItem|MenuItem|TextBox|ComboBox|DataGridTextColumn|DataGridCheckBoxColumn|DataGridComboBoxColumn|ListBox|TreeView)\b([^>]+)',re.S)
for copy,root in roots.items():
 for card,files in groups.items():
  for rel in files:
   p=root/rel
   if not p.exists():missing.append({'copy':copy,'source':rel});continue
   content=p.read_text(encoding='utf-8-sig');controls=[]
   for m in pattern.finditer(content):
    attrs=dict(re.findall(r'([\w:]+)="([^"]*)"',m.group(2)))
    controls.append({'line':content.count('\n',0,m.start())+1,'kind':m.group(1),
      **{k:v for k,v in attrs.items() if k in ['x:Name','Name','Content','Header','Text','Command','Click','Binding','ItemsSource','SelectedItem','IsChecked','IsReadOnly','Visibility']}})
   rows.append({'copy':copy,'source':rel,'card':card,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),
    'controls':controls,'disposition':'Retain capability; verify owner-specific route before any proposed consolidation'})
receipt={'utc':datetime.now(timezone.utc).isoformat(),'roots':{k:str(v) for k,v in roots.items()},'surfaces':rows,'absentFiles':missing,
 'limits':['Static controls only; code-created controls/actions remain separately reviewed',
 'Two identified source copies, not whole installed or branch inventory',
 'Retention is planning disposition, not permission to modify',
 'Bound properties and dynamically populated controls require their owning source for semantics']}
(out/'SHARED_CONTROL_INVENTORY.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2),encoding='utf-8')
lines=['# Shared controls — source-backed preservation ledger','','FOR TIM','','Existing fields and actions are preserved while the shared pages are reconciled. This ledger is supporting evidence, not a proposal to give every control its own page.','','---','','## Evidence limits','','Each control below is a static source declaration. Values, runtime visibility, native behaviour and installed availability are not proven. Code-created dialogs remain separately reviewed. Later-owner controls do not erase older retained recovery routes.','']
for row in rows:
 lines += [f"## {row['copy']} — {Path(row['source']).name}",'',f"Workflow: [{row['card']}]({row['card']}). Source: `{roots[row['copy']]/row['source']}`.",'',f"SHA256: `{row['sha256']}`. Disposition: **retain capability; reconcile route**.",'','| Line | Control | Name / label | Action / binding |','|---:|---|---|---|']
 for c in row['controls']:
  label=' · '.join(str(c[k]) for k in ['x:Name','Name','Content','Header'] if c.get(k)) or '(unnamed)'
  action=' · '.join(f'{k}: {c[k]}' for k in ['Click','Command','Binding','Text','ItemsSource','SelectedItem','IsChecked','IsReadOnly','Visibility'] if c.get(k)) or 'Owner semantics require inspection'
  lines.append(f"| {c['line']} | {c['kind']} | {label.replace('|','/')} | {action.replace('|','/')} |")
 lines.append('')
(out/'06_SHARED_CONTROL_PRESERVATION.md').write_text('\n'.join(lines),encoding='utf-8')
print(json.dumps({'sourceFileVersions':len(rows),'staticControlDeclarations':sum(len(r['controls']) for r in rows),'absentFileVersions':len(missing)}))
