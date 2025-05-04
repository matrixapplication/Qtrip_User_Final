import 'dart:io';

import 'add_new_imports.dart';
import 'get_project_name.dart';

void addRepoInDependency({required String featureName}) {
  final projectName = getProjectName();
  final newUseCaseLine = '  getIt.registerLazySingleton<${featureName}Repository>(() => ${featureName}RepositoryImp(dioClient: getIt()));\n';
  final newImport = "import 'package:${projectName}/data/repository/${featureName.toLowerCase()}_repository_imp.dart';\n";
  final newImport2 = "import 'package:${projectName}/domain/repository/${featureName.toLowerCase()}_repo.dart';\n";

  // مسار ملف injection.dart
  final injectionFile = File('lib/data/injection.dart');
  if (injectionFile.existsSync()) {
    String content = injectionFile.readAsStringSync();

    if (content.contains(featureName)) {
      print('$featureName is already registered.');
    } else {
      // تحديد مكان الإضافة
      final insertionPoint = content.lastIndexOf('Future<void> init() async {') + 'Future<void> init() async {\n'.length;

      // إضافة الكود الجديد
      content = content.substring(0, insertionPoint) +
          newUseCaseLine +
          content.substring(insertionPoint);
      content= addNewImports(content: content, newImport: newImport, featureName: featureName);
      content= addNewImports(content: content, newImport: newImport2, featureName: featureName);

      // كتابة المحتوى إلى الملف
      injectionFile.writeAsStringSync(content);
      print('Added $featureName to injection.dart ✔');
    }
  } else {
    print('Error: injection.dart file not found.');
  }
}
