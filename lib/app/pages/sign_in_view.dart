import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../global/session_controller.dart';

class SignInView extends StatelessWidget {
  const SignInView({
    super.key,
    required this.callbackURL,
  });
  final String callbackURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<SessionController>().setSignedIn(true);
            GoRouter.of(context).pushReplacement(callbackURL);
          },
          child: const Text('sign in'),
        ),
      ),
    );
  }
}
