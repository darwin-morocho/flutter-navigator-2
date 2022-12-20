import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.home,
      routes: appRoutes,
    );
  }
}
