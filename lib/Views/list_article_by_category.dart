import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/article_model.dart';

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
    super.initState();
    articles = fetchArticlesBy(widget.query);
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
          future: articles,
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
                  return Card(
                    child: Container(
                      height: 150,
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
                                    article.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(children: <Widget>[
                                        IconButton(
                                          icon:
                                              const Icon(Icons.favorite_border),
                                          onPressed: () {
                                            // Logique pour le like
                                          },
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
                  );
                },
              );
            }
          }),
    );
  }
}
