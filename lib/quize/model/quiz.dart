import 'package:testlineiq/models/questions.dart';

class Quiz {
  final int id;
  final String? name;
  final String? title;
  final String? description;
  final String? difficultyLevel;
  final String? topic;
  final DateTime time;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? duration;
  final DateTime endTime;
  final String? negativeMarks;
  final String? correctAnswerMarks;
  final bool shuffle;
  final bool showAnswers;
  final bool lockSolution;
  final bool isForm;
  final bool showMasteryOption;
  final String? readingMaterial;
  final String? quizType;
  final bool isCustom;
  final int? bannerId;
  final int? examId;
  final bool showUnanswered;
  final String? endAt;
  final String? lives;
  final String liveCount;
  final int? coinCount;
  final int? questionCount;
  final String? dailyDate;
  final int? maxMistakeCount;
  final List<dynamic> readingMaterials;
  final List<Question> questions;
  final int? progress;

  Quiz({
    required this.id,
    this.name,
    required this.title,
    required this.description,
    this.difficultyLevel,
    required this.topic,
    required this.time,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
    required this.endTime,
    required this.negativeMarks,
    required this.correctAnswerMarks,
    required this.shuffle,
    required this.showAnswers,
    required this.lockSolution,
    required this.isForm,
    required this.showMasteryOption,
    this.readingMaterial,
    this.quizType,
    required this.isCustom,
    this.bannerId,
    this.examId,
    required this.showUnanswered,
    required this.endAt,
    this.lives,
    required this.liveCount,
    required this.coinCount,
    required this.questionCount,
    required this.dailyDate,
    required this.maxMistakeCount,
    required this.readingMaterials,
    required this.questions,
    required this.progress,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      difficultyLevel: json['difficulty_level'],
      topic: json['topic'],
      time: DateTime.parse(json['time']),
      isPublished: json['is_published'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      duration: json['duration'],
      endTime: DateTime.parse(json['end_time']),
      negativeMarks: json['negative_marks'],
      correctAnswerMarks: json['correct_answer_marks'],
      shuffle: json['shuffle'],
      showAnswers: json['show_answers'],
      lockSolution: json['lock_solutions'],
      isForm: json['is_form'],
      showMasteryOption: json['show_mastery_option'],
      readingMaterial: json['reading_material'],
      quizType: json['quiz_type'],
      isCustom: json['is_custom'],
      bannerId: json['banner_id'],
      examId: json['exam_id'],
      showUnanswered: json['show_unanswered'],
      endAt: json['end_at'],
      lives: json['lives'],
      liveCount: json['live_count'],
      coinCount: json['coin_count'],
      questionCount: json['question_count'],
      dailyDate: json['daily_date'],
      maxMistakeCount: json['max_mistake_count'],
      readingMaterials: json['reading_materials'],
      questions: List<Question>.from(
          json['questions'].map((question) => Question.fromJson(question))),
      progress: json['progress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'difficulty_level': difficultyLevel,
      'topic': topic,
      'time': time.toIso8601String(),
      'is_published': isPublished,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'duration': duration,
      'end_time': endTime.toIso8601String(),
      'negative_marks': negativeMarks,
      'correct_answer_marks': correctAnswerMarks,
      'shuffle': shuffle,
      'show_answers': showAnswers,
      'lock_solutions': lockSolution,
      'is_form': isForm,
      'show_mastery_option': showMasteryOption,
      'reading_material': readingMaterial,
      'quiz_type': quizType,
      'is_custom': isCustom,
      'banner_id': bannerId,
      'exam_id': examId,
      'show_unanswered': showUnanswered,
      'end_at': endAt,
      'lives': lives,
      'live_count': liveCount,
      'coin_count': coinCount,
      'question_count': questionCount,
      'daily_date': dailyDate,
      'max_mistake_count': maxMistakeCount,
      'reading_materials': readingMaterials,
      'questions': questions.map((question) => question.toJson()).toList(),
      'progress': progress,
    };
  }
}
