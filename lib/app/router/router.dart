import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../global/session_controller.dart';
import '../my_app.dart';
import '../pages/error_view.dart';
import '../pages/home/home_view.dart';
import '../pages/home/product_view.dart';
import '../pages/home/widgets/scaffold.dart';
import '../pages/profile_view.dart';
import '../pages/sign_in_view.dart';
import 'routes.dart';

final parentNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
    initialLocation: '/sign-in',
    navigatorKey: parentNavigatorKey,
    errorBuilder: (_, state) => ErrorView(
      goRouterState: state,
    ),
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return HomeScaffold(
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: Routes.home,
            path: '/',
            builder: (_, __) => const HomeView(),
          ),
          GoRoute(
            name: Routes.product,
            path: '/product/:id',
            builder: (_, state) {
              final id = state.params['id']!;
              return ProductView(
                id: int.parse(id),
              );
            },
            redirect: (context, state) => authGuard(
              context: context,
              state: state,
              callbackURL: '/product/${state.params['id']}',
            ),
          ),
        ],
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/sign-in',
        parentNavigatorKey: parentNavigatorKey,
        builder: (_, state) {
          final callbackURL = state.queryParams['callbackURL'];
          return SignInView(
            callbackURL: callbackURL ?? '/',
          );
        },
        redirect: (context, state) {
          final isSignedIn = context.read<SessionController>().isSignedIn;
          if (isSignedIn) {
            return '/';
          }
          return null;
        },
      ),
      GoRoute(
        name: Routes.profile,
        path: '/profile',
        parentNavigatorKey: parentNavigatorKey,
        builder: (_, __) => const ProfileView(),
        redirect: (context, state) => authGuard(
          context: context,
          state: state,
          callbackURL: '/profile',
        ),
      ),
    ],
  );

  GoRouter get router => _router;
}

FutureOr<String?> authGuard({
  required BuildContext context,
  required GoRouterState state,
  required String callbackURL,
}) async {
  final isSignedIn = context.read<SessionController>().isSignedIn;
  if (isSignedIn) {
    return null;
  }
  return '/sign-in?callbackURL=$callbackURL';
}
