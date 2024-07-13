import 'package:flutter/material.dart';
import '../models/article_model.dart';

Widget CardArticle(Article article) {
  return Card(
      margin: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ImageCard(article.image, 200),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: <Widget>[
                  TextButton(
                    child: Text('Lire'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Text('Enregistré'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      // Logique pour le like
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  )
                ]))
          ]));
}

Widget CardHorizontal(Article article) {
  return Container(
      width: 300,
      child: Card(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                article.image,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.title,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
            ]),
      ));
}
