import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_test/core/router/route_name.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/circle_icon_button.dart';

class HeaderNavigation extends StatelessWidget {
  const HeaderNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CircleIconButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.goNamed(RouteName.pokemonRegionScreen);
            }
          },
        ),
      ),
    );
  }
}
