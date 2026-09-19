"""Read-only bounded plugin source inventory; writes only this planning annex.
Not compiled-command evidence, not installed status, not an AutoCAD test.
"""
import json, re, subprocess, hashlib
from pathlib import Path
from datetime import datetime, timezone

repo = Path(r'C:\Lisp Files\CE_ACAD_PLUGIN')
out = Path(__file__).parent
roots = ['Modules/Drainage','Modules/Structural','Modules/Structural.DesignCore','Modules/Manager',
         'Shared','CE.Host','CE.AI.Core','CE.AI.Harness','CE.Cloud','Installer','ReleaseAuthority','Assets']
files = subprocess.check_output(['rg','--files',*roots,'-g','*.cs','-g','*.xaml','-g','*.json',
 '-g','*.lsp','-g','*.ts','-g','!**/obj/**','-g','!**/bin/**','-g','!**/Docs/**',
 '-g','!**/Corpus/**','-g','!**/corpus/**'],cwd=repo,text=True).splitlines()
commands=[]; windows=[]; registries=[]; unresolved=[]; omitted=[]; fingerprints=[]; dynamic=[]
for rel in files:
 p=repo/rel
 if p.suffix not in ['.cs','.xaml'] and p.name!='command-registry.json': continue
 text=p.read_text(encoding='utf-8-sig',errors='replace')
 fingerprints.append({'source':rel,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
 if p.name=='command-registry.json':
  data=json.loads(text)
  for row in data.get('commands',[]): registries.append({'source':rel,**row})
 elif p.suffix=='.cs':
  constants={m.group(1):(m.group(2),text.count('\n',0,m.start())+1) for m in re.finditer(r'const\s+string\s+(\w+)\s*=\s*"([^"\n]+)"',text)}
  for m in re.finditer(r'\[CommandMethod\s*\((.*?)\)\s*\]',text,re.S):
   prefix=text[text.rfind('\n',0,m.start())+1:m.start()].strip()
   if prefix.startswith('//') or prefix.startswith('*'):
    omitted.append({'source':rel,'line':text.count('\n',0,m.start())+1,'reason':'Comment, not declaration'})
    continue
   args=m.group(1); strings=re.findall(r'"([^"\n]+)"',args)
   # One string is conventional global-name declaration. Multiple string overloads
   # are kept unresolved rather than guessing which is global/local/group.
   row={'source':rel,'line':text.count('\n',0,m.start())+1,'arguments':args.strip(),
        'candidate':strings[0] if len(strings)==1 else None,'review':'Source declaration only'}
   identifier=args.split(',')[0].strip()
   if not strings and identifier in constants:
    row['candidate'],row['constantLine']=constants[identifier]
    row['resolvedFrom']=identifier
   commands.append(row)
   if row['candidate'] is None: unresolved.append(row)
  for m in re.finditer(r'(?:new\s+(?:Window|Form)\b|class\s+\w+\s*:\s*(?:Window|Form)\b)',text):
   dynamic.append({'source':rel,'line':text.count('\n',0,m.start())+1,'declaration':m.group(0),
     'review':'May be existing XAML code-behind or code-created UI; reconcile individually'})
 elif p.suffix=='.xaml':
  root=re.search(r'<(Window|UserControl|Page)\b',text)
  if root:
   labels=[]
   for m in re.finditer(r'<(?:\w+:)?(Button|ToggleButton|CheckBox|RadioButton|TabItem|MenuItem|GroupBox|TextBox|ComboBox|DataGridTextColumn|DataGridCheckBoxColumn|ListBox|TreeView)\b([^>]+)',text):
    attrs=dict(re.findall(r'([\w:]+)="([^"]*)"',m.group(2)))
    labels.append({'kind':m.group(1),'line':text.count('\n',0,m.start())+1,
      **{k:v for k,v in attrs.items() if k in ['Content','Header','Command','Click','x:Name','Name','IsChecked','Text','Binding','ItemsSource','SelectedItem','IsReadOnly','Visibility']}})
   windows.append({'source':rel,'kind':root.group(1),'controls':labels,
       'limit':'XAML only; generated controls and code-built dialogs require separate review'})
result={'capturedUtc':datetime.now(timezone.utc).isoformat(),'sourceRoot':str(repo),
 'limits':['Read-only source declaration inventory, not compiled or installed evidence',
           'No corpus, binary outputs or original client drawings read',
           'Constant/multiple-string command attributes require manual resolution',
           'Code-built windows and native/ribbon/LISP surfaces require reconciliation'],
 'commands':commands,'unresolvedAttributes':unresolved,'omittedCommentMatches':omitted,
 'xamlSurfaces':windows,'registryRows':registries,'windowDeclarations':dynamic,'fingerprints':fingerprints}
(out/'SOURCE_INVENTORY.json').write_text(json.dumps(result,indent=2,ensure_ascii=False),encoding='utf-8')
summary={'commandAttributes':len(commands),'unresolvedAttributes':len(unresolved),
 'xamlSurfaces':len(windows),'registryRows':len(registries),
 'byModule':{r:{'attributes':sum(x['source'].replace('\\','/').startswith(r+'/') for x in commands),
 'xaml':sum(x['source'].replace('\\','/').startswith(r+'/') for x in windows)} for r in roots}}
print(json.dumps(summary,indent=2))
