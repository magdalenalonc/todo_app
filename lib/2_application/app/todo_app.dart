import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/2_application/core/routes_config.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ToDo App',
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
      ),
      routerConfig: routes,
    );
  }
}
