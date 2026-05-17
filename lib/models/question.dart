class Question {
  final String imageUrl;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.imageUrl,
    required this.options,
    required this.correctAnswerIndex,
  });
}
