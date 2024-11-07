import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'initial_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedPassword = prefs.getString('password');

    if (_usernameController.text == storedUsername &&
        _passwordController.text == storedPassword) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      setState(() {
        errorMessage = 'Usuário ou senha incorretos';
      });
    }
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
                    fillColor: Colors.grey[300], // Fundo cinza claro
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
                // Botão de login
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
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
                // Botão de navegação para a tela de registro
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'Criar conta',
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
