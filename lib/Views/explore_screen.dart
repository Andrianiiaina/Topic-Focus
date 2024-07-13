import 'package:flutter/material.dart';
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
    "Design UX",
    "football",
    "C#",
    "Biologie de synthèse",
    "Réalité augmentée",
    "Mode été 2024",
    "Cerveau social",
    "Psychologie positive",
  ];
  Future<void> fetchAndDisplayArticles(List<String> interests) async {
    String popularUrl = generateUrl(interests, 'popular');
    popularArticles = fetchArticles(popularUrl);
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
          'Explorer',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(165, 33, 149, 243),
                      Color.fromARGB(129, 155, 39, 176)
                    ],
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
                        // print('Bouton de filtrage cliqué');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const ListTile(
              title: Text(
                "Populaire",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
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
              title: Text("Explorer",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: explores.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage('assets/images/a ($index).jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 100,
                          child: Container(
                            alignment: Alignment.center,
                            color: const Color.fromARGB(113, 23, 53, 85),
                            child: Text(
                              explores[index].toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
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

  const ImageCarda(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
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
                padding: const EdgeInsets.all(10),
                color: Colors.white24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
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
