import 'dart:io';

String getProjectName() {
  final pubspecFile = File('pubspec.yaml'); // تحديد مسار pubspec.yaml

  if (pubspecFile.existsSync()) {
    final content = pubspecFile.readAsStringSync();

    final nameMatch = RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(content);
    if (nameMatch != null) {
      return nameMatch.group(1)!; // إعادة اسم المشروع
    }
  }
  throw Exception('Project name not found in pubspec.yaml');
}
