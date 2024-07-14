import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:topic/helper.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Article>> articles;
  List<bool> favoriteStates = [];

  final handler = DBHelper();
  @override
  void initState() {
    super.initState();
    articles = handler.getArticles();
    favoriteStates = false_values(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TOPIC FOCUS',
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                  itemCount: Article.interets.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: Text(
                          "#${Article.interets[i]}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          articles = handler.searchInDatabase(
                              Article.interets[i].toLowerCase());
                        });
                      },
                    );
                  }),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder<List<Article>>(
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
                      return MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return mansorCard(articles[index], index);
                          });
                    }
                  }),
            )
          ],
        ));
  }

  Widget mansorCard(Article article, index) {
    return GestureDetector(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.image,
              height: 130,
            ),
            ListTile(
              title: Text(
                article.title.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(article.date == '1'
                  ? "il y a ${article.date} jour"
                  : "il y a ${article.date} jours"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      favoriteStates[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteStates[index] ? Colors.purple : null,
                    ),
                    onPressed: () {
                      setState(() {
                        favoriteStates[index] = !favoriteStates[index];
                      });
                    },
                  ),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.watch_later), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        openBrowser(article.url);
      },
    );
  }
}
