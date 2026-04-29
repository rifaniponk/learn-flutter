import 'package:flutter/material.dart';

class PokemonsPage extends StatelessWidget {
  const PokemonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Pokemons coming soon',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

