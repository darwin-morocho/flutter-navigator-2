import 'package:flutter/material.dart';

import '../pages/home_view.dart';
import '../pages/product_view.dart';
import 'routes.dart';

Map<String, WidgetBuilder> get appRoutes {
  return {
    Routes.home: (_) => const HomeView(),
    Routes.product: (context) => ProductView(
          id: ModalRoute.of(context)!.settings.arguments as int,
        ),
  };
}
