"""Read-only bounded plugin source inventory; writes only this planning annex.
Not compiled-command evidence, not installed status, not an AutoCAD test.
"""
import json, re, subprocess
from pathlib import Path
from datetime import datetime, timezone

repo = Path(r'C:\Lisp Files\CE_ACAD_PLUGIN')
out = Path(__file__).parent
roots = ['Modules/Drainage','Modules/Structural','Modules/Structural.DesignCore','Modules/Manager',
         'Shared','CE.Host','CE.AI.Core','CE.AI.Harness','CE.Cloud','Installer','ReleaseAuthority','Assets']
files = subprocess.check_output(['rg','--files',*roots,'-g','*.cs','-g','*.xaml','-g','*.json',
 '-g','*.lsp','-g','*.ts','-g','!**/obj/**','-g','!**/bin/**','-g','!**/Docs/**',
 '-g','!**/Corpus/**','-g','!**/corpus/**'],cwd=repo,text=True).splitlines()
commands=[]; windows=[]; registries=[]; unresolved=[]
for rel in files:
 p=repo/rel
 if p.suffix not in ['.cs','.xaml'] and p.name!='command-registry.json': continue
 text=p.read_text(encoding='utf-8-sig',errors='replace')
 if p.name=='command-registry.json':
  data=json.loads(text)
  for row in data.get('commands',[]): registries.append({'source':rel,**row})
 elif p.suffix=='.cs':
  for m in re.finditer(r'\[CommandMethod\s*\((.*?)\)\s*\]',text,re.S):
   args=m.group(1); strings=re.findall(r'"([^"\n]+)"',args)
   # One string is conventional global-name declaration. Multiple string overloads
   # are kept unresolved rather than guessing which is global/local/group.
   row={'source':rel,'line':text.count('\n',0,m.start())+1,'arguments':args.strip(),
        'candidate':strings[0] if len(strings)==1 else None,'review':'Source declaration only'}
   commands.append(row)
   if len(strings)!=1: unresolved.append(row)
 elif p.suffix=='.xaml':
  root=re.search(r'<(Window|UserControl|Page)\b',text)
  if root:
   labels=[]
   for m in re.finditer(r'<(?:\w+:)?(Button|ToggleButton|CheckBox|RadioButton|TabItem|MenuItem|GroupBox)\b([^>]+)',text):
    attrs=dict(re.findall(r'([\w:]+)="([^"]*)"',m.group(2)))
    labels.append({'kind':m.group(1),'line':text.count('\n',0,m.start())+1,
      **{k:v for k,v in attrs.items() if k in ['Content','Header','Command','Click','x:Name','Name','IsChecked']}})
   windows.append({'source':rel,'kind':root.group(1),'controls':labels,
       'limit':'XAML only; generated controls and code-built dialogs require separate review'})
result={'capturedUtc':datetime.now(timezone.utc).isoformat(),'sourceRoot':str(repo),
 'limits':['Read-only source declaration inventory, not compiled or installed evidence',
           'No corpus, binary outputs or original client drawings read',
           'Constant/multiple-string command attributes require manual resolution',
           'Code-built windows and native/ribbon/LISP surfaces require reconciliation'],
 'commands':commands,'unresolvedAttributes':unresolved,'xamlSurfaces':windows,'registryRows':registries}
(out/'SOURCE_INVENTORY.json').write_text(json.dumps(result,indent=2,ensure_ascii=False),encoding='utf-8')
summary={'commandAttributes':len(commands),'unresolvedAttributes':len(unresolved),
 'xamlSurfaces':len(windows),'registryRows':len(registries),
 'byModule':{r:{'attributes':sum(x['source'].replace('\\','/').startswith(r+'/') for x in commands),
 'xaml':sum(x['source'].replace('\\','/').startswith(r+'/') for x in windows)} for r in roots}}
print(json.dumps(summary,indent=2))
