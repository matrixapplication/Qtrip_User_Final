import 'dart:io';

String addEndpoint({required String endpointName, required String endpointValue}) {
  // سطر الكود الجديد للـ endpoint
  final newEndpointLine = '  static const String $endpointName = "$endpointValue";\n';

  // مسار ملف AppURL
  final appUrlFile = File('lib/data/app_urls/app_url.dart');
  if (appUrlFile.existsSync()) {
    String content = appUrlFile.readAsStringSync();

    // التحقق من وجود الـ endpoint مسبقًا
    if (content.contains(endpointName)) {
      print('Error: $endpointName already exists in AppURL.');
    } else {
      // تحديد مكان إضافة الـ endpoint بعد التعليقات أو السطور الموجودة
      final lastEndpointIndex = content.lastIndexOf('static const String');
      if (lastEndpointIndex != -1) {
        final insertionPoint = content.indexOf('\n', lastEndpointIndex) + 1;

        // إضافة الكود الجديد في الموضع الصحيح
        content = content.substring(0, insertionPoint) +
            newEndpointLine +
            content.substring(insertionPoint);

        // كتابة المحتوى الجديد إلى الملف
        appUrlFile.writeAsStringSync(content);
        print('Added $endpointName to AppURL ✔');
      } else {
        print('Could not find a suitable place to insert the endpoint.');
      }
    }
  } else {
    print('Error: AppURL file not found.');
  }
  return endpointName;
}
