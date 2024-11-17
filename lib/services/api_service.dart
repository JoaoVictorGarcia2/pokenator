import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<Map<String, dynamic>> sendAnswer(Map<String, dynamic> answers) async {
    final response = await http.post(
      Uri.parse('$baseUrl/next_question'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(answers),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao conectar com o backend');
    }
  }
}
