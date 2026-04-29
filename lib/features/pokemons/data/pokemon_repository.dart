import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_summary.dart';

class PokemonRepository {
  PokemonRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<PokemonSummary>> fetchPokemonList({
    required int limit,
    required int offset,
  }) async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon').replace(
      queryParameters: {
        'limit': '$limit',
        'offset': '$offset',
      },
    );

    try {
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
          .map((e) => e as Map<String, dynamic>)
          .map((e) {
            final name = e['name'] as String;
            final url = e['url'] as String;
            final id = _extractIdFromUrl(url);
            return PokemonSummary(id: id, name: name);
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

