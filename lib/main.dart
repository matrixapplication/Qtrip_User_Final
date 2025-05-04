import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'app.dart';
import 'bloc.dart';
import 'core/notification/notification_service.dart';
import 'data/injection.dart' as data_injection;
import 'domain/injection.dart' as domain_injection;
import 'injection.dart' as injection;

///30/4/2025
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // print('${record.level.name}: ${record.time}: ${record.message}');
  });
  // for the responsive service to work (I don't know the reason until now)
  await Future.delayed(const Duration(milliseconds: 300));
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  // initialize Firebase
  await Firebase.initializeApp();
  final NotificationService notificationService = NotificationService();
  notificationService.init();

  await data_injection.init();
  await domain_injection.init();
  await injection.init();
  runApp(
    GenerateMultiBloc(
      child: EasyLocalization(
          supportedLocales: supportedLocales,
          path: 'assets/strings',
          fallbackLocale: supportedLocales[0],
          saveLocale: true,
          useOnlyLangCode: true,
          startLocale: supportedLocales[0],
          child:
          const MyApp()
      ),
    ),
  );
}
final supportedLocales = <Locale>[
  const Locale('en'),
  const Locale('ar'),
];
