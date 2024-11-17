import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  List<Map<String, dynamic>> pokemonData = [];

  @override
  void initState() {
    super.initState();
    _loadPokemonData();
  }

  Future<void> _loadPokemonData() async {
    // Carrega o arquivo CSV dos assets
    final rawData = await rootBundle.loadString('data/pokemon.csv');
    
    // Faz o parsing do CSV usando ";" como delimitador
    List<List<dynamic>> data = const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\n',
    ).convert(rawData);
    
    // Mapeia os dados do CSV para uma lista de Mapas
    pokemonData = data.skip(1).map((row) => {
      'id': row[0],
      'name': row[1],
      'type1': row[2],
      'type2': row[3],
      'total': row[4],
      'hp': row[5],
      'attack': row[6],
      'defense': row[7],
      'special_attack': row[8],
      'special_defense': row[9],
      'speed': row[10],
      'generation': row[11],
      'legendary': row[12] == 'True', // Converte para boolean
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
      ),
      body: pokemonData.isNotEmpty
          ? _displayPokemonList()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  // Exibir a lista de Pokémon
  Widget _displayPokemonList() {
    return ListView.builder(
      itemCount: pokemonData.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonData[index];
        return ListTile(
          title: Text(
            pokemon['name'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'Type: ${pokemon['type1']} ${pokemon['type2'] != '' ? '/ ${pokemon['type2']}' : ''}'),
          trailing: Text('HP: ${pokemon['hp']}'),
          onTap: () => _showPokemonDetails(pokemon),
        );
      },
    );
  }

  // Exibir os detalhes do Pokémon selecionado
  void _showPokemonDetails(Map<String, dynamic> pokemon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(pokemon['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type 1: ${pokemon['type1']}'),
            Text('Type 2: ${pokemon['type2']}'),
            Text('Total: ${pokemon['total']}'),
            Text('HP: ${pokemon['hp']}'),
            Text('Attack: ${pokemon['attack']}'),
            Text('Defense: ${pokemon['defense']}'),
            Text('Sp. Atk: ${pokemon['special_attack']}'),
            Text('Sp. Def: ${pokemon['special_defense']}'),
            Text('Speed: ${pokemon['speed']}'),
            Text('Generation: ${pokemon['generation']}'),
            Text('Legendary: ${pokemon['legendary'] ? 'Yes' : 'No'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}