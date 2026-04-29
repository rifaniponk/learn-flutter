import 'package:flutter/material.dart';

import '../models/pokemon_summary.dart';
import 'pokemon_card.dart';

class PokemonsGrid extends StatelessWidget {
  const PokemonsGrid({super.key, required this.pokemons});

  final List<PokemonSummary> pokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pokemons.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisExtent: 210,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokemonCard(pokemon: pokemon);
      },
    );
  }
}

