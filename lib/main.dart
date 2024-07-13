import 'package:flutter/material.dart';
import 'package:topic/Views/explore_screen.dart';
import 'package:topic/Views/feed_screen.dart';
import 'package:topic/Views/message_screen.dart';
import 'package:topic/Views/profil_screen.dart';
import 'routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Topic Focus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: routes,
      // theme: ThemeData.dark(),
      //routerDelegate: routes.routerDelegate,
      //routeInformationParser: routes.routeInformationParser,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final screens = [
    const FeedScreen(),
    const MessageScreen(),
    const ExploreScreen(),
    const ProfilScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: _customBottomNav(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _customBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
          //color: Colors.lightBlue,
          border: Border.all(style: BorderStyle.solid, color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _changeScreen(0, Icons.home_filled),
          _changeScreen(1, Icons.message),
          _changeScreen(2, Icons.explore),
          _changeScreen(3, Icons.person)
        ],
      ),
    );
  }

  Widget _changeScreen(int index, IconData icon) {
    return IconButton(
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        icon: Icon(
          icon,
          color: index == _selectedIndex
              ? Colors.purple
              : Color.fromARGB(170, 33, 149, 243),
          size: index == _selectedIndex ? 27 : 25,
        ));
  }
}
