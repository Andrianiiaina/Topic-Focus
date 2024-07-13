import 'package:flutter/material.dart';
import 'package:topic/models/article_model.dart';

class ShowArticle extends StatefulWidget {
  final Article article;
  const ShowArticle({Key? key, required this.article}) : super(key: key);

  @override
  State<ShowArticle> createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.1,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.article.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.4 - 50,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                top: 20, left: 40, right: 20),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    widget.article.title,
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 22),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text("à ${widget.percentage} %"),

                  const SizedBox(height: 10),
                  //Text("à ${widget.percentage} %"),
                  const Text('Contenu:'),
                  Text(
                    widget.article.description,
                    style: const TextStyle(
                        color: Colors.grey, fontFamily: "Roboto", fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
