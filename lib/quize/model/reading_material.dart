class ReadingMaterial {
  final int id;
  final String? keywords;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> contentSections;
  final Map<String, dynamic> practiceMaterial;

  ReadingMaterial({
    required this.id,
    required this.keywords,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.contentSections,
    required this.practiceMaterial,
  });

  factory ReadingMaterial.fromJson(Map<String, dynamic> json) {
    return ReadingMaterial(
      id: json['id'],
      keywords: json['keywords'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      contentSections: List<dynamic>.from(json['content_sections']),
      practiceMaterial: Map<String, dynamic>.from(json['practice_material']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'keywords': keywords,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'content_sections': contentSections,
      'practice_material': practiceMaterial,
    };
  }

}