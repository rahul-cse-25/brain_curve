class Option {
  final int id;
  final String? description;
  final int questionId;
  final bool isCorrect;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool unAnswered;
  final String? photoUrl;

  Option(
      {required this.id,
      required this.description,
      required this.questionId,
      required this.isCorrect,
      required this.createdAt,
      required this.updatedAt,
      this.photoUrl,
      required this.unAnswered});

  /// Factory constructor to create an Option object from JSON
  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      questionId: json['question_id'],
      isCorrect: json['is_correct'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      unAnswered: json['unanswered'],
      photoUrl: json['photo_url'],
    );
  }

  /// Method to convert an Option object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'question_id': questionId,
      'is_correct': isCorrect,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'unanswered': unAnswered,
      'photo_url': photoUrl,
    };
  }
}
