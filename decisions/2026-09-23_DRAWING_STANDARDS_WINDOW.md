# Drawing Standards window — expanded implementation authority, 23 September 2026

1. **Tim's instruction:** "BUILD A WHOLE WINDOW - layout AND the code behind it. Code only." "The scope has been widened: you may now change the view model and add commands for THIS window."
2. **Delivery:** continue `codex/ui-standards`, draft PR #126. Drawing Standards (Draw Order and Layer Colours), Label Styles and Parts Catalogue; bounded row pages, named field insertion at the cursor, normal line breaks and fixed previews. Match New Pipe's header, fixed footer, theme and spacing. Existing save/apply/cancel routes are retained.
3. **Limits:** "DO NOT OPEN AUTOCAD. DO NOT INSTALL. DO NOT MERGE." Tim's listed protected files remain untouched. The broader Settings consolidation remains with its builder.
4. **Supersedes:** the earlier XAML-only stop recorded by PR #126. Paging and field insertion are now explicitly authorised; no further approval question is needed for this scope.
5. **Checks:** all three Civil build targets with SkipDevBundle; existing Civil failure names/count plus focused paging and actual WPF layout checks. AutoCAD drawing output and interactive acceptance remain untested in this task.
