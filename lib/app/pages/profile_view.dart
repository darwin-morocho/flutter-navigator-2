import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../global/session_controller.dart';
import '../router/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<SessionController>().setSignedIn(false);
            context.goNamed(Routes.signIn);
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
