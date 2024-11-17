import 'package:flutter/material.dart';
import 'package:projetopersistencia/screens/quiz_screen.dart'; // Import atualizado para PokemonTypeQuestion
import 'package:projetopersistencia/screens/pokemon_list_screen.dart'; // Novo import para a tela da lista de Pokémons

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem do personagem
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'images/personagem.png',
                width: screenWidth * 0.6,
              ),
            ),
            // Título do app
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'POKENATOR',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            // Botão "Adivinhe meu Pokémon?"
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega para a tela PokemonTypeQuestion
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Adivinhe meu Pokémon?',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            // Botão "Ver Pokémons"
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega para a tela PokemonListScreen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PokemonListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Ver Pokémons',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
