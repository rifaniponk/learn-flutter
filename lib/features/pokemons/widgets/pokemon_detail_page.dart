import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';

class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
  });

  final int pokemonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(pokemonDetailProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Detail')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Failed to load detail\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (detail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(
                detail.imageUrl,
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                _capitalize(detail.name),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text('#${detail.id.toString().padLeft(3, '0')}'),
              const SizedBox(height: 16),
              _buildInfoRow(context, label: 'Height', value: '${detail.height}'),
              _buildInfoRow(context, label: 'Weight', value: '${detail.weight}'),
              _buildInfoRow(context, label: 'Types', value: detail.types.join(', ')),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

