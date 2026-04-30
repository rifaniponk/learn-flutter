class PokemonDetail {
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final String imageUrl;
}

