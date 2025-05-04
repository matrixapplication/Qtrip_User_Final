String addNewImports({required String content,required String newImport,required String featureName}){
  // إضافة السطر الخاص بـ import
  if (!content.contains(newImport)) {
    final importInsertionPoint = content.indexOf('import');
    content = content.substring(0, importInsertionPoint) +
        newImport +
        content.substring(importInsertionPoint);

    print('Added import for ${featureName}Cubit ✔');
  } else {
    print('Import for ${featureName}Cubit already exists in GenerateMultiBloc');
  }
  return content;
}
