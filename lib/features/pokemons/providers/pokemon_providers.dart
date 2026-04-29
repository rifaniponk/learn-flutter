import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pokemon_repository.dart';
import '../models/pokemon_summary.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (_) => PokemonRepository(),
);

final pokemonListProvider = AsyncNotifierProvider<PokemonListController, List<PokemonSummary>>(
  PokemonListController.new,
);

class PokemonListController extends AsyncNotifier<List<PokemonSummary>> {
  @override
  Future<List<PokemonSummary>> build() async {
    // Keep the fetched list in memory when switching tabs.
    ref.keepAlive();

    final repository = ref.read(pokemonRepositoryProvider);
    return repository.fetchPokemonList(limit: 20, offset: 0);
  }
}

