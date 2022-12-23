import 'package:flutter/material.dart';

import 'pages/splash_view.dart';
import 'router/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.initialAppLink,
  });
  final Uri? initialAppLink;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouterMixin {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _init();
      },
    );
  }

  Future<void> _init() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _loading
          ? const SplashView()
          : MaterialApp.router(
              routerConfig: router,
            ),
    );
  }
}
