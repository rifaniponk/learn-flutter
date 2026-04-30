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
    final colorScheme = Theme.of(context).colorScheme;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.secondaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.network(
                        detail.imageUrl,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _capitalize(detail.name),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '#${detail.id.toString().padLeft(3, '0')}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: detail.types
                            .map(
                              (type) => Chip(
                                label: Text(_capitalize(type)),
                                backgroundColor: colorScheme.primary.withValues(
                                  alpha: 0.12,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                context,
                title: 'Overview',
                child: Column(
                  children: [
                    _buildInfoRow(
                      context,
                      label: 'Base Exp',
                      value: '${detail.baseExperience}',
                    ),
                    _buildInfoRow(
                      context,
                      label: 'Height',
                      value: '${detail.height}',
                    ),
                    _buildInfoRow(
                      context,
                      label: 'Weight',
                      value: '${detail.weight}',
                    ),
                    _buildInfoRow(context, label: 'Order', value: '${detail.order}'),
                    _buildInfoRow(
                      context,
                      label: 'Default',
                      value: detail.isDefault ? 'Yes' : 'No',
                    ),
                    _buildInfoRow(
                      context,
                      label: 'Species',
                      value: _capitalize(detail.species),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionCard(
                context,
                title: 'Abilities',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: detail.abilities
                      .map((ability) => Chip(label: Text(_capitalize(ability))))
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionCard(
                context,
                title: 'Stats',
                child: Column(
                  children: detail.stats.entries
                      .map(
                        (entry) => _buildInfoRow(
                          context,
                          label: _capitalize(entry.key),
                          value: '${entry.value}',
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionCard(
                context,
                title: 'Sprites',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (detail.frontDefaultSprite != null)
                      _buildSpriteCard(
                        context,
                        title: 'Front',
                        url: detail.frontDefaultSprite!,
                      ),
                    if (detail.frontShinySprite != null)
                      _buildSpriteCard(
                        context,
                        title: 'Shiny',
                        url: detail.frontShinySprite!,
                      ),
                    if (detail.backDefaultSprite != null)
                      _buildSpriteCard(
                        context,
                        title: 'Back',
                        url: detail.backDefaultSprite!,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionCard(
                context,
                title: 'Forms & Items',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forms: ${detail.forms.isEmpty ? 'No forms' : detail.forms.map(_capitalize).join(', ')}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Held Items: ${detail.heldItems.isEmpty ? 'No held items' : detail.heldItems.map(_capitalize).join(', ')}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionCard(
                context,
                title: 'Moves',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total moves: ${detail.moves.length}'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: detail.moves
                          .take(24)
                          .map((move) => Chip(label: Text(_capitalize(move))))
                          .toList(),
                    ),
                    if (detail.moves.length > 24) ...[
                      const SizedBox(height: 8),
                      Text('...and ${detail.moves.length - 24} more'),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildSectionCard(
                context,
                title: 'Cries & Versions',
                child: Column(
                  children: [
                    _buildInfoRow(
                      context,
                      label: 'Latest',
                      value: detail.criesLatest ?? '-',
                    ),
                    _buildInfoRow(
                      context,
                      label: 'Legacy',
                      value: detail.criesLegacy ?? '-',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detail.gameIndices.isEmpty
                          ? 'No game versions'
                          : detail.gameIndices.map(_capitalize).join(', '),
                    ),
                  ],
                ),
              ),
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

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSpriteCard(
    BuildContext context, {
    required String title,
    required String url,
  }) {
    return SizedBox(
      width: 110,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 6),
              Image.network(url, width: 72, height: 72, fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}

