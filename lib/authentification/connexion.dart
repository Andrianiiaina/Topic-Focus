import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/fond.jpeg'),
        fit: BoxFit.cover,
      )),
      child: Center(
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Créer un compte",
            style: TextStyle(
                fontSize: 45,
                fontFamily: 'italic',
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 50,
            width: 300,
            child: TextField(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white, //fond textfield
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white // borderColor
                                ),
                        borderRadius: BorderRadius.all(Radius.circular(40))))),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 50,
            width: 300,
            child: TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, //fond textfield
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white // borderColor
                          ),
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 50,
            width: 300,
            child: TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, //fond textfield
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // borderColor
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Register')),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("________________ ou ________________"),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /**
              *  Image.network(
                "img/link.png",
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Image.network(
                "img/insta.jpg",
                width: 30,
                height: 30,
              ),
              */
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Vous avez déjà un compte? Se connecter",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'verdana',
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
        ]),
      ),
    ));
  }
}
