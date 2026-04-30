import '../models/pokemon_detail.dart';
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

  Future<PokemonDetail> fetchPokemonDetail({
    required int id,
  }) async {
    try {
      final detail = await _apiService.fetchPokemonDetail(id: id);
      return PokemonDetail(
        id: detail.id,
        name: detail.name,
        height: detail.height,
        weight: detail.weight,
        baseExperience: detail.baseExperience,
        isDefault: detail.isDefault,
        order: detail.order,
        species: detail.species,
        types: detail.types,
        imageUrl: _buildArtworkUrl(detail.id),
        abilities: detail.abilities,
        moves: detail.moves,
        forms: detail.forms,
        heldItems: detail.heldItems,
        stats: detail.stats,
        gameIndices: detail.gameIndices,
        frontDefaultSprite: detail.frontDefaultSprite,
        frontShinySprite: detail.frontShinySprite,
        backDefaultSprite: detail.backDefaultSprite,
        criesLatest: detail.criesLatest,
        criesLegacy: detail.criesLegacy,
      );
    } catch (e) {
      throw Exception('PokeAPI error while fetching pokemon detail: $e');
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

  String _buildArtworkUrl(int id) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}

