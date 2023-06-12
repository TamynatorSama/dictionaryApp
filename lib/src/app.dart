import 'package:dictionary_app/dictionary_page.dart';
import 'package:dictionary_app/src/settings/custom_theme.dart';
import 'package:flutter/material.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: customTheme,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'com.example.dictionaryApp',
          theme: CustomTheme.lightTheme,
          home: const DictionaryPage(),
          darkTheme: CustomTheme.darkTheme,
          themeMode: customTheme.currentTheme,
          // routes: ,
          // onGenerateRoute: (RouteSettings routeSettings) {
          //   return MaterialPageRoute<void>(
          //     settings: routeSettings,
          //     builder: (BuildContext context) {
          //       switch (routeSettings.name) {
          //         case SettingsView.routeName:
          //           return SettingsView(controller: settingsController);
          //         case SampleItemDetailsView.routeName:
          //           return const SampleItemDetailsView();
          //         case SampleItemListView.routeName:
          //         default:
          //           return const SampleItemListView();
          //       }
          //     },
          //   );
          // },
        );
      },
    );
  }
}
