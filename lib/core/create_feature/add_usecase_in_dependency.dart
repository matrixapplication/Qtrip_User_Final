import 'dart:io';

import 'add_new_imports.dart';
import 'get_project_name.dart';

void addUseCaseInDependency({required String featureName}) {
  final projectName = getProjectName();
  final newUseCaseLine = '  getIt.registerLazySingleton(() => ${featureName}UseCase(repository: getIt()));\n';
  final newImport = "import 'package:${projectName}/domain/usecase/${featureName.toLowerCase()}/${featureName.toLowerCase()}_usecase.dart';\n";

  // مسار ملف injection.dart
  final injectionFile = File('lib/domain/injection.dart');
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

      // كتابة المحتوى إلى الملف
      injectionFile.writeAsStringSync(content);
      print('Added $featureName to injection.dart ✔');
    }
  } else {
    print('Error: injection.dart file not found.');
  }
}
