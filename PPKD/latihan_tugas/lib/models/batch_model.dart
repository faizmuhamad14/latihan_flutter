class BatchModel {
  final int id;
  final String title;

  BatchModel({
    required this.id,
    required this.title,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: json['id'],
      title: json['title'] ?? (json['name'] ?? 'Batch ${json['id']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
