import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_api_item.dart';
import '../models/pokemon_detail_api_item.dart';

class PokemonApiService {
  PokemonApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<PokemonApiItem>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon').replace(
      queryParameters: {
        'limit': '$limit',
        'offset': '$offset',
      },
    );

    final response = await _client
        .get(
          uri,
          headers: const {'Accept': 'application/json'},
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      final bodySnippet = response.body.isEmpty
          ? ''
          : ' Body: ${response.body.substring(0, response.body.length.clamp(0, 200))}';

      throw Exception(
        'PokeAPI request failed: HTTP ${response.statusCode}.$bodySnippet',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final results = decoded['results'] as List<dynamic>;

    return results
        .map((entry) => entry as Map<String, dynamic>)
        .map(
          (entry) => PokemonApiItem(
            name: entry['name'] as String,
            url: entry['url'] as String,
          ),
        )
        .toList();
  }

  Future<PokemonDetailApiItem> fetchPokemonDetail({
    required int id,
  }) async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon/$id');

    final response = await _client
        .get(
          uri,
          headers: const {'Accept': 'application/json'},
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      final bodySnippet = response.body.isEmpty
          ? ''
          : ' Body: ${response.body.substring(0, response.body.length.clamp(0, 200))}';

      throw Exception(
        'PokeAPI request failed: HTTP ${response.statusCode}.$bodySnippet',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final typeEntries = decoded['types'] as List<dynamic>;
    final abilityEntries = decoded['abilities'] as List<dynamic>;
    final moveEntries = decoded['moves'] as List<dynamic>;
    final formEntries = decoded['forms'] as List<dynamic>;
    final heldItemEntries = decoded['held_items'] as List<dynamic>;
    final statEntries = decoded['stats'] as List<dynamic>;
    final gameIndexEntries = decoded['game_indices'] as List<dynamic>;
    final sprites = decoded['sprites'] as Map<String, dynamic>;
    final cries = decoded['cries'] as Map<String, dynamic>?;
    final species = decoded['species'] as Map<String, dynamic>;

    return PokemonDetailApiItem(
      id: decoded['id'] as int,
      name: decoded['name'] as String,
      height: decoded['height'] as int,
      weight: decoded['weight'] as int,
      baseExperience: decoded['base_experience'] as int? ?? 0,
      isDefault: decoded['is_default'] as bool? ?? true,
      order: decoded['order'] as int? ?? 0,
      species: species['name'] as String,
      types: typeEntries
          .map((entry) => entry as Map<String, dynamic>)
          .map((entry) => entry['type'] as Map<String, dynamic>)
          .map((type) => type['name'] as String)
          .toList(),
      abilities: abilityEntries
          .map((entry) => entry as Map<String, dynamic>)
          .map((entry) {
            final abilityMap = entry['ability'] as Map<String, dynamic>;
            final abilityName = abilityMap['name'] as String;
            final isHidden = entry['is_hidden'] as bool? ?? false;
            return isHidden ? '$abilityName (hidden)' : abilityName;
          })
          .toList(),
      moves: moveEntries
          .map((entry) => entry as Map<String, dynamic>)
          .map((entry) => entry['move'] as Map<String, dynamic>)
          .map((move) => move['name'] as String)
          .toList(),
      forms: formEntries
          .map((entry) => entry as Map<String, dynamic>)
          .map((entry) => entry['name'] as String)
          .toList(),
      heldItems: heldItemEntries
          .map((entry) => entry as Map<String, dynamic>)
          .map((entry) => entry['item'] as Map<String, dynamic>)
          .map((item) => item['name'] as String)
          .toList(),
      stats: {
        for (final entry in statEntries.map((e) => e as Map<String, dynamic>))
          ((entry['stat'] as Map<String, dynamic>)['name'] as String):
              (entry['base_stat'] as int? ?? 0),
      },
      gameIndices: gameIndexEntries
          .map((entry) => entry as Map<String, dynamic>)
          .map((entry) => entry['version'] as Map<String, dynamic>)
          .map((version) => version['name'] as String)
          .toList(),
      frontDefaultSprite: sprites['front_default'] as String?,
      frontShinySprite: sprites['front_shiny'] as String?,
      backDefaultSprite: sprites['back_default'] as String?,
      criesLatest: cries?['latest'] as String?,
      criesLegacy: cries?['legacy'] as String?,
    );
  }
}

