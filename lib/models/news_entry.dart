import 'dart:convert';

List<NewsEntry> newsEntryFromJson(String str) {
  try {
    final decoded = json.decode(str);
    if (decoded is List) {
      return List<NewsEntry>.from(decoded.map((x) => NewsEntry.fromJson(x)));
    } else {
      print('Error: Expected List but got ${decoded.runtimeType}');
      return [];
    }
  } catch (e) {
    print('Error parsing JSON: $e');
    print('Problematic JSON string: $str');
    return [];
  }
}

String newsEntryToJson(List<NewsEntry> data) {
  try {
    return json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  } catch (e) {
    print('Error converting to JSON: $e');
    return '[]';
  }
}

class NewsEntry {
  String id;
  String title;
  String content;
  String category;
  String thumbnail;
  int newsViews;
  DateTime createdAt;
  bool isFeatured;
  int userId;

  NewsEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.thumbnail,
    required this.newsViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
  });

  factory NewsEntry.fromJson(Map<String, dynamic> json) {
    try {
      return NewsEntry(
        id: _parseString(json["id"]),
        title: _parseString(json["title"]),
        content: _parseString(json["content"]),
        category: _parseString(json["category"]),
        thumbnail: _parseString(json["thumbnail"] ?? ""),
        newsViews: _parseInt(json["news_views"]),
        createdAt: _parseDateTime(json["created_at"]),
        isFeatured: _parseBool(json["is_featured"]),
        userId: _parseInt(json["user_id"]),
      );
    } catch (e) {
      print('Error creating NewsEntry from JSON: $e');
      print('Problematic JSON: $json');
      // Return default values instead of crashing
      return NewsEntry(
        id: '',
        title: 'Error loading title',
        content: 'Error loading content',
        category: 'unknown',
        thumbnail: '',
        newsViews: 0,
        createdAt: DateTime.now(),
        isFeatured: false,
        userId: 0,
      );
    }
  }

  // Helper methods for safe parsing
  static String _parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Error parsing date: $value');
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  static bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    if (value is int) return value != 0;
    return false;
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "id": id,
        "title": title,
        "content": content,
        "category": category,
        "thumbnail": thumbnail,
        "news_views": newsViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
      };
    } catch (e) {
      print('Error converting NewsEntry to JSON: $e');
      return {
        "id": "",
        "title": "Error",
        "content": "Error",
        "category": "error",
        "thumbnail": "",
        "news_views": 0,
        "created_at": DateTime.now().toIso8601String(),
        "is_featured": false,
        "user_id": 0,
      };
    }
  }

  @override
  String toString() {
    return 'NewsEntry{id: $id, title: $title}';
  }
}