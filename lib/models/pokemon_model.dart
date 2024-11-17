// lib/models/pokemon_model.dart
class Pokemon {
  final int id;
  final String name;
  final String type1;
  final String? type2;
  final int total;
  final int hp;
  final int attack;
  final int defense;
  final int spAtk;
  final int spDef;
  final int speed;
  final int generation;
  final bool legendary;

  Pokemon({
    required this.id,
    required this.name,
    required this.type1,
    this.type2,
    required this.total,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAtk,
    required this.spDef,
    required this.speed,
    required this.generation,
    required this.legendary,
  });

  // Método para criar um Pokémon a partir de um Map
  factory Pokemon.fromMap(Map<String, dynamic> data) {
    return Pokemon(
      id: int.parse(data['#']),
      name: data['Name'],
      type1: data['Type 1'],
      type2: data['Type 2'] != '' ? data['Type 2'] : null,
      total: int.parse(data['Total']),
      hp: int.parse(data['HP']),
      attack: int.parse(data['Attack']),
      defense: int.parse(data['Defense']),
      spAtk: int.parse(data['Sp. Atk']),
      spDef: int.parse(data['Sp. Def']),
      speed: int.parse(data['Speed']),
      generation: int.parse(data['Generation']),
      legendary: data['Legendary'] == 'True',
    );
  }
}
