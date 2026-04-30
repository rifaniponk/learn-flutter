class PokemonDetailApiItem {
  const PokemonDetailApiItem({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
}

