import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_test/core/router/route_name.dart';
import 'package:pokemon_test/core/theme/image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pokeballController;
  late final AnimationController _logoController;
  late final Animation<double> _pokeballScale;
  late final Animation<double> _logoOpacity;

  @override
  void initState() {
    super.initState();

    _pokeballController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pokeballScale = CurvedAnimation(
      parent: _pokeballController,
      curve: Curves.easeOutBack,
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _pokeballController.forward().then((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      _logoController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.goNamed(RouteName.generationScreen);
    });
  }

  @override
  void dispose() {
    _pokeballController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAsset.backgroundGenerationImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _pokeballScale,
                  child: Image.asset(ImageAsset.logo, width: 150, height: 150),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _logoOpacity,
                  child: Image.asset(
                    ImageAsset.textPokemon,
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
