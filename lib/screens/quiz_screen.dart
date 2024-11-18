import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:csv/csv.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Question {
  final String questionText;
  final List<String> options;
  final String column;
  final dynamic checkValue;

  Question({
    required this.questionText,
    required this.options,
    required this.column,
    this.checkValue,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> pokemons = [];
  List<Map<String, dynamic>> filteredPokemons = [];
  List<Question> questions = [];
  List<Question> randomizedQuestions = [];
  late Question currentQuestion;
  int currentQuestionIndex = 0;
  Random random = Random();
  Set<int> askedQuestions = {};
  bool isLoading = true;

  Map<String, dynamic>? pokemonData;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await rootBundle.rootBundle.loadString('data/pokemon.csv');
      List<List<dynamic>> csvData =
          const CsvToListConverter(fieldDelimiter: ';').convert(data);

      pokemons = csvData.skip(1).map((row) {
        return {
          'name': row[1],
          'type1': row[2].toString().toLowerCase(),
          'type2': row[3].toString().toLowerCase(),
          'total': row[4],
          'hp': row[5],
          'attack': row[6],
          'defense': row[7],
          'spAtk': row[8],
          'spDef': row[9],
          'speed': row[10],
          'generation': row[11],
          'legendary':
              row[12].toString().toLowerCase() == 'true' ? 'sim' : 'não',
        };
      }).toList();

      pokemons = pokemons
          .where((pokemon) => !pokemon['name'].toString().contains("Mega"))
          .toList();

      questions = [
        Question(questionText: 'O Pokémon é do tipo Fogo?', options: ['Sim', 'Não'], column: 'type1', checkValue: 'fire'),
        Question(questionText: 'O Pokémon é do tipo Água?', options: ['Sim', 'Não'], column: 'type1', checkValue: 'water'),
        Question(questionText: 'O Pokémon é do tipo Elétrico?', options: ['Sim', 'Não'], column: 'type1', checkValue: 'electric'),
        Question(questionText: 'O Pokémon é do tipo Grama?', options: ['Sim', 'Não'], column: 'type1', checkValue: 'grass'),
        Question(questionText: 'O Pokémon é Lendário?', options: ['Sim', 'Não'], column: 'legendary', checkValue: 'sim'),
        Question(questionText: 'O Pokémon tem mais de 500 de total?', options: ['Sim', 'Não'], column: 'total', checkValue: 500),
        Question(questionText: 'O Pokémon tem mais de 100 de velocidade?', options: ['Sim', 'Não'], column: 'speed', checkValue: 100),
        Question(questionText: 'O Pokémon é do tipo Venenoso?', options: ['Sim', 'Não'], column: 'type2', checkValue: 'poison'),
        Question(questionText: 'O Pokémon tem mais de 60 de HP?', options: ['Sim', 'Não'], column: 'hp', checkValue: 60),
        Question(questionText: 'O Pokémon tem mais de 70 de ataque?', options: ['Sim', 'Não'], column: 'attack', checkValue: 70),
        Question(questionText: 'O Pokémon tem mais de 50 de defesa?', options: ['Sim', 'Não'], column: 'defense', checkValue: 50),
        Question(questionText: 'O Pokémon tem mais de 60 de defesa especial?', options: ['Sim', 'Não'], column: 'spDef', checkValue: 60),
        Question(questionText: 'O Pokémon tem mais de 80 de velocidade?', options: ['Sim', 'Não'], column: 'speed', checkValue: 80),
        Question(questionText: 'O Pokémon pertence a uma geração maior que 3?', options: ['Sim', 'Não'], column: 'generation', checkValue: 3),
        Question(questionText: 'O Pokémon possui tipo secundário Voador?', options: ['Sim', 'Não'], column: 'type2', checkValue: 'flying'),
        Question(questionText: 'O Pokémon possui ataque especial acima de 100?', options: ['Sim', 'Não'], column: 'spAtk', checkValue: 100),
        Question(questionText: 'O Pokémon é do tipo Psíquico?', options: ['Sim', 'Não'], column: 'type1', checkValue: 'psychic'),
        Question(questionText: 'O Pokémon tem mais de 120 de ataque físico?', options: ['Sim', 'Não'], column: 'attack', checkValue: 120),
        Question(questionText: 'O Pokémon é da geração 4?', options: ['Sim', 'Não'], column: 'generation', checkValue: 4),
        Question(questionText: 'O Pokémon possui tipo secundário Sombrio?', options: ['Sim', 'Não'], column: 'type2', checkValue: 'dark'),
        Question(questionText: 'O Pokémon possui defesa acima de 90?', options: ['Sim', 'Não'], column: 'defense', checkValue: 90),
        Question(questionText: 'O Pokémon tem mais de 75 de HP?', options: ['Sim', 'Não'], column: 'hp', checkValue: 75),
      ];

      randomizedQuestions = List.from(questions)..shuffle();

      setState(() {
        filteredPokemons = List.from(pokemons);
        currentQuestion = randomizedQuestions[currentQuestionIndex];
        isLoading = false;
      });
    } catch (e) {
      print("Erro ao carregar os dados do CSV: $e");
    }
  }

  void answerQuestion(String answer) {
    setState(() {
      if (askedQuestions.contains(currentQuestionIndex)) return;
      askedQuestions.add(currentQuestionIndex);

      filteredPokemons = filteredPokemons.where((pokemon) {
        var value = pokemon[currentQuestion.column];
        if (currentQuestion.column.contains('type')) {
          String type1 = pokemon['type1'] ?? '';
          String type2 = pokemon['type2'] ?? '';
          return answer == 'Sim'
              ? (type1 == currentQuestion.checkValue ||
                  type2 == currentQuestion.checkValue)
              : (type1 != currentQuestion.checkValue &&
                  type2 != currentQuestion.checkValue);
        } else if (currentQuestion.column == 'legendary') {
          return answer == 'Sim' ? value == 'sim' : value == 'não';
        } else {
          int attributeValue = int.parse(value.toString());
          int checkValue = currentQuestion.checkValue as int;
          return answer == 'Sim'
              ? attributeValue > checkValue
              : attributeValue <= checkValue;
        }
      }).toList();

      if (filteredPokemons.length == 1) {
        fetchPokemonData(filteredPokemons[0]['name']);
      } else if (filteredPokemons.isEmpty ||
          currentQuestionIndex >= randomizedQuestions.length - 1) {
        makeFinalGuess();
      } else {
        currentQuestionIndex++;
        currentQuestion = randomizedQuestions[currentQuestionIndex];
      }
    });
  }

  Future<void> fetchPokemonData(String name) async {
    try {
      final response = await http.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/${name.toLowerCase()}'));
      if (response.statusCode == 200) {
        setState(() {
          pokemonData = jsonDecode(response.body);
        });
      } else {
        print('Erro ao buscar dados do Pokémon.');
      }
    } catch (e) {
      print("Erro: $e");
    }
  }

  void makeFinalGuess() {
    if (filteredPokemons.isNotEmpty) {
      fetchPokemonData(
          filteredPokemons[random.nextInt(filteredPokemons.length)]['name']);
    } else {
      showError();
    }
  }

  void showError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Não consegui adivinhar!'),
        content: const Text('Infelizmente não consegui encontrar o Pokémon.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetQuiz();
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      filteredPokemons = List.from(pokemons);
      randomizedQuestions.shuffle();
      askedQuestions.clear();
      currentQuestion = randomizedQuestions[currentQuestionIndex];
      pokemonData = null;
    });
  }

  void navigateToInitialScreen() {
    Navigator.pushNamed(context, '/initial_screen');
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Quiz de Pokémon'),
            ),
            body: Container(
              color: const Color.fromARGB(255, 20, 107, 148), 
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (pokemonData != null) ...[
                        Text(
                          pokemonData!['name'].toString().toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              pokemonData!['sprites']['versions']
                                  ['generation-v']['black-white']
                                  ['animated']['front_default'],
                              height: 100,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Erro ao carregar imagem'),
                            ),
                            Image.network(
                              pokemonData!['sprites']['versions']
                                  ['generation-v']['black-white']
                                  ['animated']['back_default'],
                              height: 100,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Erro ao carregar imagem'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Número de perguntas feitas: ${askedQuestions.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Este é seu Pokémon?',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: navigateToInitialScreen,
                              child: const Text('Sim'),
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: resetQuiz,
                              child: const Text('Não'),
                            ),

                          ],
                        ),
                      ] else ...[
                        Text(
                          currentQuestion.questionText,
                          style: const TextStyle(
                            fontSize: 28, 
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ...currentQuestion.options.map(
                          (option) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () => answerQuestion(option),
                            child: Text(option),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
