import 'package:testlineiq/models/reading_material.dart';
import 'option.dart';

class Question {
  final int id;
  final String? description;
  final String? difficultyLevel;
  final String? topic;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? detailedSolution;
  final String? type;
  final bool isMandatory;
  final bool showInFeed;
  final String? pyqLabel;
  final int topicId;
  final int? readingMaterialId;
  final DateTime? fixedAt;
  final String? fixSummary;
  final String? createdBy;
  final String? updatedBy;
  final String? quizLevel;
  final String? questionFrom;
  final String? language;
  final String? photoUrl;
  final String? photoSolutionUrl;
  final bool isSaved;
  final String? tag;
  final List<Option> options;
  final ReadingMaterial readingMaterial;

  Question({
    required this.id,
    this.description,
    this.difficultyLevel,
    this.topic,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    this.detailedSolution,
    this.type,
    required this.isMandatory,
    required this.showInFeed,
    this.pyqLabel,
    required this.topicId,
    required this.readingMaterialId,
    required this.fixedAt,
    this.fixSummary,
    this.createdBy,
    this.updatedBy,
    this.quizLevel,
    this.questionFrom,
    this.language,
    this.photoUrl,
    this.photoSolutionUrl,
    required this.isSaved,
    this.tag,
    required this.options,
    required this.readingMaterial,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'],
      difficultyLevel: json['difficulty_level'],
      topic: json['topic'],
      isPublished: json['is_published'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      detailedSolution: json['detailed_solution'],
      type: json['type'],
      isMandatory: json['is_mandatory'],
      showInFeed: json['show_in_feed'],
      pyqLabel: json['pyq_label'],
      topicId: json['topic_id'],
      readingMaterialId: json['reading_material_id'],
      fixedAt:
          json['fixed_at'] != null ? DateTime.parse(json['fixed_at']) : null,
      fixSummary: json['fix_summary'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      quizLevel: json['quiz_level'],
      questionFrom: json['question_from'],
      language: json['language'],
      photoUrl: json['photo_url'],
      photoSolutionUrl: json['photo_solution_url'],
      isSaved: json['is_saved'],
      tag: json['tag'],
      options: json['options'] != null
          ? List<Option>.from(
              json['options'].map((option) => Option.fromJson(option)))
          : [],
      readingMaterial: ReadingMaterial.fromJson(json['reading_material']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'difficulty_level': difficultyLevel,
      'topic': topic,
      'is_published': isPublished,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'detailed_solution': detailedSolution,
      'type': type,
      'is_mandatory': isMandatory,
      'show_in_feed': showInFeed,
      'pyq_label': pyqLabel,
      'topic_id': topicId,
      'reading_material_id': readingMaterialId,
      'fixed_at': fixedAt?.toIso8601String(),
      'fix_summary': fixSummary,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'quiz_level': quizLevel,
      'question_from': questionFrom,
      'language': language,
      'photo_url': photoUrl,
      'photo_solution_url': photoSolutionUrl,
      'is_saved': isSaved,
      'tag': tag,
      'options': options.map((option) => option.toJson()).toList(),
      'reading_material': readingMaterial.toJson(),
    };
  }
}
