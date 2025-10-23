import 'package:go_router/go_router.dart';
import 'package:pokemon_test/core/router/route_name.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/views/pokemon_detail_page.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/views/generation_screen.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/views/pokemon_region_screen.dart';
import 'package:pokemon_test/features/splash/presentation/views/splash.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteName.splashScreen,
    routes: [
      GoRoute(
        name: RouteName.splashScreen,
        path: RouteName.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteName.generationScreen,
        path: RouteName.generationScreen,
        builder: (context, state) => GenerationScreen(),
      ),
      GoRoute(
        name: RouteName.pokemonRegionScreen,
        path: RouteName.pokemonRegionScreen,
        builder: (context, state) {
          final generationId =
              int.tryParse(state.uri.queryParameters['generationId'] ?? '1') ??
              1;
          return PokemonRegionScreen(generationId: generationId);
        },
      ),
      GoRoute(
        name: RouteName.pokemonDetailsScreen,
        path: RouteName.pokemonDetailsScreen,
        builder: (context, state) {
          final pokemonName = state.uri.queryParameters['name'] ?? '';
          return PokemonDetailsPage(pokemonName: pokemonName);
        },
      ),
    ],
  );
}
