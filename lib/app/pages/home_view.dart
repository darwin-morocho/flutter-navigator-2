import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../my_app.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _list = <Product>[];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 50; i++) {
      final faker = Faker();
      _list.add(
        Product(
          id: i,
          name: faker.food.dish(),
          image: faker.image.image(
            keywords: ['food'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (_, index) {
          final product = _list[index];
          return Card(
            child: InkWell(
              onTap: () {
                final myAppState =
                    context.findAncestorStateOfType<MyAppState>();
                myAppState?.delegate.setNewRoutePath(
                  Uri.parse('/product/${product.id}'),
                );
              },
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(product.image),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _list.length,
      ),
    );
  }
}
