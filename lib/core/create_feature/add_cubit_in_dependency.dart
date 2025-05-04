import 'dart:io';
import 'add_new_imports.dart';
import 'get_project_name.dart';

void addCubitInDependency({required String featureName,String? featureFileName, required List<String> dependencies, String? injectionFilePath}) {
  final newCubitLine = StringBuffer();
  final projectName =getProjectName();
  final newImport = "import 'package:${projectName}/presentation/modules/${featureFileName}/${featureFileName}_cubit.dart';\n";

  newCubitLine.write('  getIt.registerLazySingleton(() => ${featureName}Cubit(');
  if (dependencies.isNotEmpty) {
    newCubitLine.write(dependencies.map((dep) => '$dep: getIt()').join(', '));
  }
  newCubitLine.write('));\n');

  // مسار ملف الـ injection.dart

  final injectionFile =
  injectionFilePath !=null?
  File('lib/${injectionFilePath}/injection.dart'):
  File('lib/injection.dart');
  if (injectionFile.existsSync()) {
    String content = injectionFile.readAsStringSync();

    // التحقق من وجود الكيوبت مسبقًا
    if (content.contains(featureName)) {
      print('$featureName is already registered.');
    } else {
      final lastRegisterIndex = content.lastIndexOf('getIt.registerLazySingleton(() =>');
      if (lastRegisterIndex != -1) {
        final insertionPoint = content.indexOf('\n', lastRegisterIndex) + 1;
        content = content.substring(0, insertionPoint) +
            newCubitLine.toString() +
            content.substring(insertionPoint);


        content= addNewImports(content: content, newImport: newImport, featureName: featureName);

        // حفظ الملف
        injectionFile.writeAsStringSync(content);
        print('Added $featureName to injection.dart ✔');
      } else {
        print('Could not find a suitable insertion point.');
      }
    }
  } else {
    print('Error: injection.dart file not found.');
  }
}
