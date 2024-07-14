import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/article_model.dart';
import 'package:topic/helper.dart';

class ListArticleBy extends StatefulWidget {
  final String query;
  const ListArticleBy({super.key, required this.query});

  @override
  State<ListArticleBy> createState() => _ListArticleByState();
}

class _ListArticleByState extends State<ListArticleBy> {
  late Future<List<Article>> articles;

  final handler = DBHelper();
  List<bool> favoriteStates = [];
  @override
  void initState() {
    super.initState();
    articles = handler.searchInDatabase(widget.query.toLowerCase());

    favoriteStates = false_values(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.query.toString(),
          style: const TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.go('/explore');
              },
              icon: const Icon(Icons.search)),
          //sIconButton(onPressed: () {}, icon: const Icon(Icons.person))
        ],
      ),
      body: FutureBuilder<List<Article>>(
          future: articles.then((value) => filterArticles(value)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No articles found'));
            } else {
              final articles = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return GestureDetector(
                    child: Card(
                      child: Container(
                        //height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      article.title.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(children: <Widget>[
                                          Text(
                                            "${article.date} j",
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12),
                                          ),
                                          ListTile(
                                            title: Text(
                                              article.title.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(article.date == '1'
                                                ? "il y a ${article.date} jour"
                                                : "il y a ${article.date} jours"),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.share),
                                            onPressed: () {
                                              // Logique pour les commentaires
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.watch_later),
                                            onPressed: () {
                                              // Logique pour les commentaires
                                            },
                                          )
                                        ]))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  article.image,
                                  // fit: BoxFit.cover,
                                  height: 130,
                                ),
                              )
                            ]),
                      ),
                    ),
                    onTap: () => openBrowser(article.url),
                  );
                },
              );
            }
          }),
    );
  }
}
