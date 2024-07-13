import 'package:flutter/material.dart';
import 'package:topic/Views/card_image.dart';
import 'package:topic/Views/list_article_by_category.dart';
import 'package:topic/models/article_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Article>> recentArticles;
  late Future<List<Article>> popularArticles;
  late Future<List<Article>> todayArticles;
  final List<String> interets = [
    "football",
    "Biologie de synthèse",
    "IA Générative"
  ];
  final List<String> explores = [
    "football",
    "Biologie de synthèse",
    "IA Générative",
    "football",
    "Biologie de synthèse",
    "IA Générative",
  ];
  Future<void> fetchAndDisplayArticles(List<String> interests) async {
    // Génération des URLs pour les différentes catégories
    // String recentUrl = generateUrl(interests, 'recent');
    String popularUrl = generateUrl(interests, 'popular');
    // String todayUrl = generateUrl(interests, 'today');

    // Récupération des articles
    // recentArticles = fetchArticles(recentUrl);
    popularArticles = fetchArticles(popularUrl);
    // todayArticles = fetchArticles(todayUrl);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndDisplayArticles(interets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPLORER'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Recherche...',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: () {
                        // Action à réaliser lors du clic sur le bouton de filtrage
                        print('Bouton de filtrage cliqué');
                      },
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text("Populaire en ce moment"),
              trailing: TextButton(
                child: const Text('Plus'),
                onPressed: () {},
              ),
            ),
            Container(
              height: 230,
              child: FutureBuilder<List<Article>>(
                future: popularArticles,
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
                      itemCount: articles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        // return CardHorizontal(article);
                        return ImageCarda(
                            title: article.title,
                            subtitle: "",
                            imageUrl: article.image);
                      },
                    );
                  }
                },
              ),
            ),
            const ListTile(
              title: Text("Explorer"),
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.all(16),
              child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: explores.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        height: 50,
                        child: Text(
                          explores[index].toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                ListArticleBy(query: explores[index])),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCarda extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  ImageCarda(
      {required this.title, required this.subtitle, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            //width: double.infinity,
            //height: 200,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
/*
FutureBuilder<List<Article>>(
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
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: () {},
                  //=> _launchURL(article.url)
                );
              },
            );
          }
        },
         void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
 */