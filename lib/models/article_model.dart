import 'dart:convert';
import 'package:http/http.dart' as http;

class Article {
  final String title;
  final String description;
  final String image;
  final String url;
  final String source;
  final String date;

  Article({
    required this.title,
    required this.image,
    required this.description,
    required this.url,
    required this.source,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String today = DateTime.now().toIso8601String().substring(0, 10);
    String date =
        "${DateTime.tryParse(json['publishedAt'])!.day}/${DateTime.tryParse(json['publishedAt'])!.month}";
    return Article(
      title: json['title'].toString(),
      image: json['urlToImage'].toString(),
      description: json['description'].toString(),
      url: json['url'].toString(),
      source: json['source']['name'].toString(),
      date: date,
    );
  }

/**
 *   static List<Article> articles = [
    Article(
        title: 'The Future of Generative AI: Innovations and Challenges',
        description:
            'An in-depth analysis of the current state and future potential of generative AI technologies.',
        image: 'assets/images/aa (1).jpg',
        url: 'https://example.com/future-of-generative-ai'),
    Article(
        title: 'Synthetic Biology: Designing Life from Scratch',
        description:
            'Exploring the groundbreaking advancements in synthetic biology and its implications for the future.',
        image: 'assets/images/aa (2).jpg',
        url: 'https://example.com/synthetic-biology'),
    Article(
        title: 'The Evolution of Football: A Game of Strategy and Skill',
        description:
            'A comprehensive look at the history and evolution of football, from its origins to the modern game.',
        image: 'assets/images/aa (3).jpg',
        url: 'https://example.com/evolution-of-football'),
    Article(
        title: 'Generative AI in Creative Industries',
        description:
            'How generative AI is transforming creative industries such as art, music, and design.',
        image: 'assets/images/aa (4).jpg',
        url: 'https://example.com/generative-ai-creative-industries')
  ];
 */
}

Future<List<Article>> fetchArticles(String url) async {
  final response = await http.get(Uri.parse(url));
  // final url =
  //    'https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&pageSize=10&apiKey=$apikey';
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final articlesJson = jsonResponse['articles'] as List;

    return articlesJson.map((json) => Article.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load articles');
  }
}

Future<List<Article>> fetchArticlesBy(String query) async {
  //final response = await http.get(Uri.parse(url));
  String apiKey = "cc7e05da68ed43b6895773e3d1161727";
  final url =
      'https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&pageSize=10&apiKey=$apiKey';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final articlesJson = jsonResponse['articles'] as List;
    await Future.delayed(Duration(seconds: 2));
    return articlesJson.map((json) => Article.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load articles');
  }
}

// Fonction pour générer l'URL avec plusieurs centres d'intérêt
String generateUrl(List<String> interests, String filter) {
  String apiKey = "cc7e05da68ed43b6895773e3d1161727";
  String baseUrl = 'https://newsapi.org/v2/';
  String query = interests.join(' OR ');
  String endpoint;

  switch (filter) {
    case 'popular':
      endpoint =
          'everything?q=$query&sortBy=popularity&pageSize=5&apiKey=$apiKey';
      break;
    case 'today':
      String today = DateTime.now().toIso8601String().substring(0, 10);
      endpoint =
          'everything?q=$query&from=$today&to=$today&pageSize=5&apiKey=$apiKey';
      break;
    case 'recent':
      endpoint =
          'everything?q=$query&sortBy=publishedAt&pageSize=5&apiKey=$apiKey';
      break;
    default:
      endpoint = '';
  }

  return baseUrl + endpoint;
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
