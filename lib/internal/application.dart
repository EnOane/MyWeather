import 'package:education/presentation/router/app_router.dart';
import 'package:education/presentation/themes/main.theme.dart';
import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather',
      debugShowCheckedModeBanner: false,
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
