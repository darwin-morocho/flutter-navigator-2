import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';

class ColorsScaffold extends StatefulWidget {
  const ColorsScaffold({super.key, required this.child});
  final Widget child;

  @override
  State<ColorsScaffold> createState() => _ColorsScaffoldState();
}

class _ColorsScaffoldState extends State<ColorsScaffold> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = () {
      final location = GoRouter.of(context).location;
      if (location.startsWith('/red')) {
        return 0;
      }
      if (location.startsWith('/green')) {
        return 1;
      }
      return 2;
    }();

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          if (index == selectedIndex && context.canPop()) {
            context.pop();
            return;
          }

          final routeName = () {
            if (index == 0) {
              return Routes.red;
            }
            if (index == 1) {
              return Routes.green;
            }
            return Routes.blue;
          }();

          context.goNamed(routeName);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.reddit,
              color: Colors.red,
            ),
            label: 'Red',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.reddit,
              color: Colors.green,
            ),
            label: 'Green',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.reddit,
              color: Colors.blue,
            ),
            label: 'Blue',
          ),
        ],
      ),
    );
  }
}
