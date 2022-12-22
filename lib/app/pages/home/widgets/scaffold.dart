import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final counter = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        counter.value++;
      },
    );
  }

  @override
  void didUpdateWidget(covariant HomeScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        counter.value++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ValueListenableBuilder<int>(
          valueListenable: counter,
          builder: (_, value, __) {
            return AppBar(
              leading: value > 0 && GoRouter.of(context).canPop()
                  ? BackButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    )
                  : null,
              actions: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(
                      Routes.profile,
                    );
                  },
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            );
          },
        ),
      ),
      body: widget.child,
    );
  }
}
