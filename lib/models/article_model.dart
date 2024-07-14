import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Article {
  final String title;
  final String image;
  final String url;
  final String date;
  final String description;
  dynamic stockage;
  Article({
    required this.title,
    required this.image,
    required this.url,
    required this.description,
    required this.date,
    this.stockage,
  });
  // Convertir un article en Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'url': url,
      'description': description,
      'date': date,
      'stockage': DateTime.now().toIso8601String().split('T')[0].toString(),
    };
  }

  static List<String> interets = [
    "IA",
    "psychologie",
    "technologie",
    "science",
    "santé",
  ];

  // Convertir un Map en article
  Article.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        image = map['image'],
        url = map['url'],
        description = map['description'],
        date = map['date'],
        stockage = map['stockage'];

  factory Article.fromJson(Map<String, dynamic> json) {
    DateTime givenDate = DateFormat('yyyy-MM-dd').parse(json['publishedAt']);
    DateTime today = DateTime.now();
    int differenceInDays = today.difference(givenDate).inDays;
    return Article(
      title: json['title'].toString(),
      image: json['urlToImage'].toString(),
      url: json['url'].toString(),
      description: json['content'].toString(),
      date: "$differenceInDays",
    );
  }
}

const platform = MethodChannel('com.example.topic/browser');

Future<void> openBrowser(String url) async {
  try {
    await platform.invokeMethod('openBrowser', {'url': url});
  } on PlatformException catch (e) {
    print("Failed to open browser: '${e.message}'.");
  }
}

Future<List<Article>> fetchArticles(String q) async {
  String apikey = "cc7e05da68ed43b6895773e3d1161727";
  final url =
      'https://newsapi.org/v2/everything?q=$q&sortBy=publishedAt&language=fr&pageSize=60&apiKey=$apikey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final articlesJson = jsonResponse['articles'] as List;
    await Future.delayed(const Duration(seconds: 2));

    return articlesJson.map((json) => Article.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load articles');
  }
}

Future<List<Article>> filterArticles(List<Article> articles) async {
  List<Future<Article?>> articlesf = articles.map((article) async {
    bool imgReacheable = await test(article.image);
    return imgReacheable ? article : null;
  }).toList();
  List<Article?> filtered = await Future.wait(articlesf);
  return filtered.whereType<Article>().toList();
}

Future<bool> test(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    if (response.statusCode == 200) return true;
  } catch (e) {
    return false;
  }
  return false;
}

List<bool> false_values(int length) {
  return List<bool>.filled(length, false);
}
