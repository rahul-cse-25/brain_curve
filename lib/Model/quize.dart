import 'dart:convert';

class Quiz {
  final String subject;
  final String question;
  final List<String> options;
  final String correctAnswer;

  Quiz({
    required this.subject,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  // 🛠️ Factory method to create object from JSON
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      subject: json['subject'] ?? '',
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['correct_answer'] ?? '',
    );
  }

  // 🔄 Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
    };
  }

  // 📌 Convert JSON List to List of QuizModel objects
  static List<Quiz> fromJsonList(String jsonString) {
    final Map<String, dynamic> decodedData = json.decode(jsonString);
    final List<dynamic> quizList = decodedData['quiz'] ?? [];

    return quizList.map((quiz) => Quiz.fromJson(quiz)).toList();
  }
}
