import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _register() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, preencha todos os campos';
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E2E), // Cinza mais escuro
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagem de fundo menor
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Image.asset(
                    'images/poke.png',
                    width: 150, // Ajusta o tamanho da imagem
                    height: 150,
                  ),
                ),
                // Campo de entrada para usuário
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                // Campo de entrada para senha
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                // Botão de criação de conta
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16),
                // Botão de navegação para a tela de login
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Já tenho conta',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
