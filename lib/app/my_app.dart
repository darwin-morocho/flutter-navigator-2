// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'pages/home_view.dart';
import 'pages/product_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final delegate = MyRouterDelegate(
    pages: [
      MyPage(
        (_) => HomeView(),
        path: '/',
      ),
      MyPage(
        (data) => ProductView(
          id: int.parse(
            data['id']!,
          ),
        ),
        path: '/product/:id',
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: delegate,
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}

class MyPage {
  final String path;
  final Widget Function(Map<String, String> data) builder;

  MyPage(
    this.builder, {
    required this.path,
  });
}

class MyRouterDelegate extends RouterDelegate<Uri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final List<MyPage> pages;

  late List<Page> _navigatorPages;

  MyRouterDelegate({
    required this.pages,
  }) {
    final initialPage = pages.firstWhere(
      (element) => element.path == '/',
    );
    _navigatorPages = [
      MaterialPage(
        name: '/',
        child: initialPage.builder(
          {},
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _navigatorPages,
      onPopPage: (route, result) {
        if (route.didPop(result)) {
          _navigatorPages.removeWhere(
            (element) => element.name == route.settings.name,
          );
          notifyListeners();
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Uri configuration) async {
    final path = configuration.path;
    final data = <String, String>{};

    final index = pages.indexWhere(
      (e) {
        if (e.path == path) {
          return true;
        }

        if (e.path.contains('/:')) {
          ///  /product/123
          final lastIndex = e.path.lastIndexOf('/:');
          final substring = e.path.substring(
            0,
            lastIndex,
          );
          if (path.startsWith(substring)) {
            final key = e.path.substring(lastIndex + 2, e.path.length);
            final value = path.substring(lastIndex + 1, path.length);
            data[key] = value;
            return true;
          }
        }
        return false;
      },
    );
    if (index != -1) {
      _navigatorPages = [
        ..._navigatorPages,
        MaterialPage(
          name: path,
          child: pages[index].builder(data),
        ),
      ];
      notifyListeners();
    }
  }

  @override
  Uri? get currentConfiguration => Uri.parse(
        _navigatorPages.last.name ?? '',
      );

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}

class MyRouteInformationParser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) {
    return Future.value(
      Uri.parse(routeInformation.location ?? ''),
    );
  }

  @override
  RouteInformation? restoreRouteInformation(Uri configuration) {
    return RouteInformation(
      location: configuration.toString(),
    );
  }
}
