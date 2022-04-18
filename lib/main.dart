import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? nameFromAPI;
  final String url = 'https://api.github.com/users/saadkhan1216';
  bool isloading = false;
  callApi() async {
    var uri = Uri.parse(url);
    setState(() {
      isloading = true;
    });
    try {
      var response = await http.get(uri);
      var responseString = response.body;
      Map<String, dynamic> parsedJson = jsonDecode(responseString);
      setState(() {
        nameFromAPI = parsedJson['name'];
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('API'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (nameFromAPI != null) Text(nameFromAPI!),
              if (isloading) CircularProgressIndicator(),
              ElevatedButton(
                  onPressed: () {
                    callApi();
                  },
                  child: Text('Click to call API'))
            ],
          ),
        )
        /*ListView.builder(
        itemBuilder: (childContext,index) => Text('Hello World $index'),
      itemCount: 10,),
      */
        );
  }
}
