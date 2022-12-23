import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../global/session_controller.dart';
import '../my_app.dart';
import '../pages/colors/color_detail_view.dart';
import '../pages/colors/color_view.dart';
import '../pages/colors/widgets/colors_scaffold.dart';
import '../pages/error_view.dart';
import '../pages/home/home_view.dart';
import '../pages/home/product_view.dart';
import '../pages/home/widgets/scaffold.dart';
import '../pages/profile_view.dart';
import '../pages/sign_in_view.dart';
import 'routes.dart';

mixin RouterMixin on State<MyApp> {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter? _router;

  GoRouter get router {
    _router ??= GoRouter(
      initialLocation: widget.initialAppLink?.toString() ?? '/red',
      navigatorKey: rootNavigatorKey,
      redirect: (context, state) {
        print(state.error);
        return null;
      },
      errorBuilder: (_, state) => ErrorView(
        goRouterState: state,
      ),
      routes: [
        ShellRoute(
          builder: (_, __, child) {
            return ColorsScaffold(child: child);
          },
          routes: [
            GoRoute(
              name: Routes.red,
              path: '/red',
              builder: (_, __) => const ColorView(
                color: Colors.red,
                colorName: 'RED',
              ),
              routes: [
                ColorDetailView.getRoute(
                  Colors.red,
                ),
              ],
            ),
            GoRoute(
              name: Routes.green,
              path: '/green',
              builder: (_, __) => const ColorView(
                color: Colors.green,
                colorName: 'GREEN',
              ),
              routes: [
                ColorDetailView.getRoute(
                  Colors.green,
                ),
              ],
            ),
            GoRoute(
              name: Routes.blue,
              path: '/blue',
              builder: (_, __) => const ColorView(
                color: Colors.blue,
                colorName: 'BLUE',
              ),
              routes: [
                ColorDetailView.getRoute(
                  Colors.blue,
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
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
          parentNavigatorKey: rootNavigatorKey,
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
          parentNavigatorKey: rootNavigatorKey,
          builder: (_, __) => const ProfileView(),
          redirect: (context, state) => authGuard(
            context: context,
            state: state,
            callbackURL: '/profile',
          ),
        ),
      ],
    );
    return _router!;
  }
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
