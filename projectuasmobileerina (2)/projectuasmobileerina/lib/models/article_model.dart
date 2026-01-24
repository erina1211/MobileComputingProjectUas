class ArticleModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}
