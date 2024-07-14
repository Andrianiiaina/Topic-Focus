import 'package:sqflite/sqflite.dart';
import 'models/article_model.dart';

const String path = 'ehsttfgyst.db';

class DBHelper {
  initializeDB() async {
    return openDatabase(path, version: 1, onCreate: (database, version) async {
      await database.execute('''
        CREATE TABLE articles(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          image TEXT,
          url TEXT,
          date TEXT,
          description TEXT,
          stockage TEXT
        )
      ''');

      final List<Article> articles = await fetchArticles(
              "(football OR euro 2024 OR IA génerative OR psychologie cognitive)")
          .then((value) => filterArticles(value));
      articles.forEach((article) {
        insertArticle(article);
      });
      database.close();
    });
  }

  static Future<int> insertArticle(Article article) async {
    final Database db = await openDatabase(path);
    return await db.insert('articles', article.toMap());
  }

  Future<List<Article>> getArticles() async {
    final Database db = await openDatabase(path);
    final List<Map<String, dynamic>> maps = await db.query('articles');
    return List.generate(maps.length, (i) {
      return Article.fromMap(maps[i]);
    });
  }

  Future<List<Article>> searchInDatabase(String searchTerm) async {
    final Database db = await openDatabase(path);
    String query = '''
    SELECT * 
    FROM articles
    WHERE title LIKE ?
    OR description LIKE ?
    ''';

    List<String> searchTerms = ['%$searchTerm%', '%$searchTerm%'];

    List<Map<String, dynamic>> result = await db.rawQuery(query, searchTerms);
    return List.generate(result.length, (i) {
      return Article.fromMap(result[i]);
    });
  }
}
