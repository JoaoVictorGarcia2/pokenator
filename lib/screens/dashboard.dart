import 'package:flutter/material.dart';
import 'package:projetopersistencia/screens/pokemon_type_question.dart'; // Import atualizado para PokemonTypeQuestion

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
            // Botão "Qual é este Pokémon?"
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega para a tela PokemonTypeQuestion
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PokemonTypeQuestion(),
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
                  'Qual é este Pokémon?',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
