import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Article>> articles;
  final List<String> interets = [
    "football",
    "Biologie de synthèse",
    "IA Générative",
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
          title: Text('Topic focus'),
          actions: [Icon(Icons.list), Icon(Icons.notification_add)],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: interets.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          articles = fetchArticlesBy(interets[i]);
                        });
                      },
                      child: Text("#${interets[i]}",
                          style: TextStyle(fontSize: 12, color: Colors.purple)),
                    );
                  }),
            ),
            Expanded(
              flex: 7,
              child: FutureBuilder<List<Article>>(
                  future: articles.then((value) => filterArticles(value)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No articles found'));
                    } else {
                      final articles = snapshot.data!;
                      return MasonryGridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return MansorCard(article: articles[index]);
                          });
                    }
                  }),
            )
          ],
        ));
  }
}

class MansorCard extends StatelessWidget {
  final Article article;

  MansorCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              "${article.title} \n ${article.date}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Action à réaliser lors du clic sur le bouton Favori
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Action à réaliser lors du clic sur le bouton Partager
                  },
                ),
                IconButton(
                  icon: Icon(Icons.watch_later),
                  onPressed: () {
                    // Action à réaliser lors du clic sur le bouton Plus tard
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
