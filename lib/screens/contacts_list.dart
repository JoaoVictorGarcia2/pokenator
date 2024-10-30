import 'package:flutter/material.dart';

class PokemonTypeQuestion extends StatelessWidget {
  const PokemonTypeQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagem do personagem
            Image.asset('images/personagem.png'), // Verifique o caminho da imagem

            // Texto da pergunta
            const Text(
              'Seu Pokémon é do tipo Fogo?',
              style: TextStyle(fontSize: 24),
            ),

            // Ícone de tipo de Pokémon (opcional)
            Image.asset('assets/fire_type_icon.png'), // Verifique o caminho do ícone

            const SizedBox(height: 20),

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para "Provavelmente Sim"
                  },
                  child: const Text('Provavelmente Sim'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para "Provavelmente Não"
                  },
                  child: const Text('Provavelmente Não'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para "Sim"
                  },
                  child: const Text('Sim'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para "Não Sei"
                  },
                  child: const Text('Não Sei'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para "Não"
                  },
                  child: const Text('Não'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
