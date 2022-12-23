import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/global/session_controller.dart';
import 'app/my_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialAppLink = await AppLinks().getInitialAppLink();
  setPathUrlStrategy();
  final preferences = await SharedPreferences.getInstance();
  runApp(
    Provider<SessionController>(
      create: (_) => SessionController(preferences),
      child: MyApp(
        initialAppLink: initialAppLink,
      ),
    ),
  );
}
