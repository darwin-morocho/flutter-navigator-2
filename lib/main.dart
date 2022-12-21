import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/my_app.dart';

void main(List<String> args) {
  setPathUrlStrategy();
  runApp(
    const MyApp(),
  );
}
