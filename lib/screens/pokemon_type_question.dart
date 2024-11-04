import 'package:flutter/material.dart';

class PokemonTypeQuestion extends StatelessWidget {
  const PokemonTypeQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset(
              'images/background1.png', // Verifique o caminho do fundo
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagem do personagem com tamanho ajustado
                Image.asset(
                  'images/personagem.png', // Verifique o caminho da imagem
                  width: screenWidth * 0.4, // Ajuste a largura para 40% da largura da tela
                ),

                const SizedBox(height: 20),

                // Texto da pergunta e ícone do tipo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Seu Pokémon é do tipo Fogo?',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'images/fire_type_icon.png', // Verifique o caminho do ícone
                      width: 30, // Ajuste o tamanho do ícone
                      height: 30,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Botões de resposta
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Lógica para "Provavelmente Sim"
                              },
                              child: const Text('Provavelmente Sim'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Lógica para "Provavelmente Não"
                              },
                              child: const Text('Provavelmente Não'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Lógica para "Sim"
                              },
                              child: const Text('Sim'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Lógica para "Não Sei"
                              },
                              child: const Text('Não Sei'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Lógica para "Não"
                              },
                              child: const Text('Não'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
