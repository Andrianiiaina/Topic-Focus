import 'package:flutter/material.dart';
import 'package:topic/Views/show_article.dart';
import '../models/article_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Article>> articles;
  //late List<bool> favoriteStates;
  final List<String> interets = [
    "Biologie de synthèse",
    "IA Générative",
    "Psychologie cognitive"
  ];
  Future<void> fetchAndDisplayArticles(List<String> interests) async {
    String recentUrl = generateUrl(interests, 'recent');
    articles = fetchArticles(recentUrl);
  }

  @override
  void initState() {
    super.initState();
    fetchAndDisplayArticles(interets);
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
                  itemCount: interets.length,
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
                          "#${interets[i]}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          articles = fetchArticlesBy(interets[i]);
                        });
                      },
                    );
                  }),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder<List<Article>>(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(article.date),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Action à réaliser lors du clic sur le bouton Partager
                    },
                  ),
                  /** IconButton(
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
                    }
                    ,
                  ), 
                  */
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // Action à réaliser lors du clic sur le bouton Partager
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.watch_later),
                    onPressed: () {
                      // Action à réaliser lors du clic sur le bouton Plus tard
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ShowArticle(article: article)),
          ),
        );
      },
    );
  }
}
