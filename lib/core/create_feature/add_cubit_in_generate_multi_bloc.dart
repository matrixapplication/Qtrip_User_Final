import 'dart:io';

import 'add_new_imports.dart';

void addCubitInGenerateMultiBloc({required String featureName,String? featureFileName,required String projectName, }) {
  final generateMultiBlocPath = "${Directory.current.path}/lib/bloc.dart";
  final newBlocProvider = "        BlocProvider(create: (_) => getIt<${featureName}Cubit>()),\n";
  final newImport = "import 'package:${projectName}/presentation/modules/${featureFileName}/${featureFileName}_cubit.dart';\n";

  final multiBlocFile = File(generateMultiBlocPath);
  if (multiBlocFile.existsSync()) {
    String content = multiBlocFile.readAsStringSync();

    // إضافة السطر الخاص بـ BlocProvider
    if (!content.contains("getIt<${featureName}Cubit>()")) {
      final insertionPoint = content.indexOf('providers: [') + 'providers: ['.length;
      content = content.substring(0, insertionPoint) +
          '\n' +
          newBlocProvider +
          content.substring(insertionPoint);

      print('Updated GenerateMultiBloc with ${featureName}Cubit ✔');
    } else {
      print('${featureName}Cubit already exists in GenerateMultiBloc');
    }

    // إضافة السطر الخاص بـ import
    content= addNewImports(content: content, newImport: newImport, featureName: featureName);
    // حفظ التعديلات
    multiBlocFile.writeAsStringSync(content);
  } else {
    print('Error: GenerateMultiBloc file not found at $generateMultiBlocPath');
  }

}
