import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Api());
}

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

List users = [];
DateTime date = DateTime.now();

class _ApiState extends State<Api> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("API class"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            var email = user['email'];
            var picture = user['picture']['medium'];
            var name = user['name']['first'];
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0.1, 5, 0),
              child: ListTile(
                trailing: Text(
                  '${date.hour} ago',
                  style: const TextStyle(color: Colors.white),
                ),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                tileColor: const Color.fromARGB(200, 7, 94, 84),
                title: Text(
                  name,
                  style: TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  email,
                  style: const TextStyle(color: Colors.greenAccent),
                ),
                leading: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                        child: Image(image: NetworkImage(picture)))),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: fetchData,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    print("functioning");
    const uri = "https://randomuser.me/api/?results=10";
    final url = Uri.parse(uri);
    final response = await http.get(url);
    final body = response.body;
    final JSon = jsonDecode(body);

    setState(() {
      users = JSon["results"];
    });
  }
}
