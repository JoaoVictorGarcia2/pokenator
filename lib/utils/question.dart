class Question {
  final String questionText;
  final List<String> options;
  final String column; // Novo campo para o nome da coluna

  Question({
    required this.questionText,
    required this.options,
    required this.column,
  });
}
