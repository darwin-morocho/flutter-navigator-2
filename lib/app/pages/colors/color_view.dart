import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ColorView extends StatelessWidget {
  const ColorView({
    super.key,
    required this.color,
    required this.colorName,
    this.showAppBar = true,
  });
  final MaterialColor color;
  final String colorName;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showAppBar)
          AppBar(
            backgroundColor: color,
            title: Text(colorName),
          ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              final shade = 100 * index + 100;
              final variant = color[shade]!;
              return InkWell(
                onTap: () {
                  final location = context.namedLocation(
                    colorName.toLowerCase(),
                  );
                  context.push('$location/details/$shade');
                },
                child: Container(
                  height: 100,
                  color: variant,
                ),
              );
            },
            itemCount: 9,
          ),
        ),
      ],
    );
  }
}
