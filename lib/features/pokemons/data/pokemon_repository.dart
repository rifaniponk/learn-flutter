import '../models/pokemon_summary.dart';
import '../services/pokemon_api_service.dart';

class PokemonRepository {
  PokemonRepository({
    required PokemonApiService apiService,
  }) : _apiService = apiService;

  final PokemonApiService _apiService;

  Future<List<PokemonSummary>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final results = await _apiService.fetchPokemonList(
        limit: limit,
        offset: offset,
      );

      return results
          .map((e) {
            final id = _extractIdFromUrl(e.url);
            return PokemonSummary(id: id, name: e.name);
          })
          .toList();
    } catch (e) {
      throw Exception('PokeAPI error while fetching pokemons: $e');
    }
  }

  int _extractIdFromUrl(String url) {
    // PokeAPI urls are like: https://pokeapi.co/api/v2/pokemon/1/
    final segments = Uri.parse(url).pathSegments;
    final lastNonEmpty = segments.lastWhere(
      (segment) => segment.isNotEmpty,
      orElse: () => '',
    );
    return int.tryParse(lastNonEmpty) ?? 0;
  }
}

