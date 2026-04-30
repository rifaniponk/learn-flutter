class PokemonDetailApiItem {
  const PokemonDetailApiItem({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.isDefault,
    required this.order,
    required this.species,
    required this.types,
    required this.abilities,
    required this.moves,
    required this.forms,
    required this.heldItems,
    required this.stats,
    required this.gameIndices,
    required this.frontDefaultSprite,
    required this.frontShinySprite,
    required this.backDefaultSprite,
    required this.criesLatest,
    required this.criesLegacy,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseExperience;
  final bool isDefault;
  final int order;
  final String species;
  final List<String> types;
  final List<String> abilities;
  final List<String> moves;
  final List<String> forms;
  final List<String> heldItems;
  final Map<String, int> stats;
  final List<String> gameIndices;
  final String? frontDefaultSprite;
  final String? frontShinySprite;
  final String? backDefaultSprite;
  final String? criesLatest;
  final String? criesLegacy;
}

