import 'package:flutter/material.dart';

import '../models/pokemon_summary.dart';
import 'pokemon_card.dart';
import 'pokemon_detail_page.dart';

class PokemonsGrid extends StatelessWidget {
  const PokemonsGrid({
    super.key,
    required this.pokemons,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  final List<PokemonSummary> pokemons;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final showLoadingTile = isLoadingMore;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
          onLoadMore();
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pokemons.length + (showLoadingTile ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisExtent: 210,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          if (index >= pokemons.length) {
            return const Card(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final pokemon = pokemons[index];
          return PokemonCard(
            pokemon: pokemon,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PokemonDetailPage(pokemonId: pokemon.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

