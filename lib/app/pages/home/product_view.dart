import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.id,
  });
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'PRODUCT: $id',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
