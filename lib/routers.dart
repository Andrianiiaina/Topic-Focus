import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:topic/Views/explore_screen.dart';
import 'package:topic/Views/feed_screen.dart';
import 'package:topic/Views/list_article_by_category.dart';
import 'package:topic/Views/message_screen.dart';
import 'package:topic/Views/profil_screen.dart';
import 'main.dart';

GoRouter routes = GoRouter(routes: [
  GoRoute(
      routes: [
        GoRoute(
            path: 'feed',
            builder: (BuildContext context, GoRouterState state) =>
                const FeedScreen()),
        GoRoute(
            path: 'message',
            builder: (BuildContext context, GoRouterState state) =>
                const MessageScreen()),
        GoRoute(
            path: 'explore',
            builder: (BuildContext context, GoRouterState state) =>
                const ExploreScreen()),
        GoRoute(
            path: 'profil',
            builder: (BuildContext context, GoRouterState state) =>
                const ProfilScreen()),
        //GoRoute(
        //     path: 'list_by/:url',
        //      builder: (BuildContext context, GoRouterState state) =>
        //         const ListArticleBy(url:url )),
      ],
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const MyHomePage())
]);
