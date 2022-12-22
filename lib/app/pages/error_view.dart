import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.goRouterState,
  });
  final GoRouterState goRouterState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              goRouterState.error.toString(),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                context.pushReplacementNamed(
                  Routes.home,
                );
              },
              child: const Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
