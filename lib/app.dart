
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'core/resources/theme/theme.dart';
import 'core/routing/navigation_services.dart';
import 'core/routing/route_generator.dart';
import 'core/routing/routes.dart';

BuildContext? appContext;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return
      MaterialApp(
      theme: lightTheme,
      color:Theme.of(context).scaffoldBackgroundColor,
      localizationsDelegates: [CountryLocalizations.delegate, ...context.localizationDelegates,],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'كيو تريب',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RouteGenerator.generateBaseRoute,
      builder: (context, child) => Directionality(
        textDirection: context.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: child ?? const SizedBox(),
      ),
    );
  }
}
