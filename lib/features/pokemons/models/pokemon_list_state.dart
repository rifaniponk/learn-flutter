import 'pokemon_summary.dart';

class PokemonListState {
  const PokemonListState({
    required this.pokemons,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final List<PokemonSummary> pokemons;
  final bool hasMore;
  final bool isLoadingMore;

  PokemonListState copyWith({
    List<PokemonSummary>? pokemons,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PokemonListState(
      pokemons: pokemons ?? this.pokemons,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

