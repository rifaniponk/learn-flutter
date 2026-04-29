import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/pokemon_api_item.dart';

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
}

