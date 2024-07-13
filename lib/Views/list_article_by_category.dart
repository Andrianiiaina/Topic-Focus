import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';
import 'card_image.dart';

class ListArticleBy extends StatefulWidget {
  final String query;
  const ListArticleBy({super.key, required this.query});

  @override
  State<ListArticleBy> createState() => _ListArticleByState();
}

class _ListArticleByState extends State<ListArticleBy> {
  late Future<List<Article>> articles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articles = fetchArticlesBy(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.query),
        actions: [
          IconButton(
              onPressed: () {
                context.go('/explore');
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person))
        ],
      ),
      body: FutureBuilder<List<Article>>(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No articles found'));
            } else {
              final articles = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'article.title',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    article.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.favorite),
                                          onPressed: () {
                                            // Logique pour le like
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.share),
                                          onPressed: () {
                                            // Logique pour les commentaires
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.watch_later),
                                          onPressed: () {
                                            // Logique pour les commentaires
                                          },
                                        )
                                      ]))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Image.network(
                                article.image,
                                // fit: BoxFit.cover,
                                height: 130,
                              ),
                              flex: 1,
                            )
                          ]),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
