import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pokemon_repository.dart';
import '../models/pokemon_list_state.dart';
import '../services/pokemon_api_service.dart';

final pokemonApiServiceProvider = Provider<PokemonApiService>(
  (_) => PokemonApiService(),
);

final pokemonRepositoryProvider = Provider<PokemonRepository>(
  (ref) => PokemonRepository(
    apiService: ref.read(pokemonApiServiceProvider),
  ),
);

final pokemonListProvider = AsyncNotifierProvider<PokemonListController, PokemonListState>(
  PokemonListController.new,
);

class PokemonListController extends AsyncNotifier<PokemonListState> {
  static const _pageSize = 20;

  late final PokemonRepository _repository;

  @override
  Future<PokemonListState> build() async {
    // Keep the fetched list in memory when switching tabs.
    ref.keepAlive();

    _repository = ref.read(pokemonRepositoryProvider);
    final initialPokemons = await _repository.fetchPokemonList(
      limit: _pageSize,
      offset: 0,
    );

    return PokemonListState(
      pokemons: initialPokemons,
      hasMore: initialPokemons.length == _pageSize,
      isLoadingMore: false,
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final nextPokemons = await _repository.fetchPokemonList(
        limit: _pageSize,
        offset: current.pokemons.length,
      );

      state = AsyncData(
        current.copyWith(
          pokemons: [...current.pokemons, ...nextPokemons],
          hasMore: nextPokemons.length == _pageSize,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      // Keep already loaded items visible if load-more fails.
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }
}

