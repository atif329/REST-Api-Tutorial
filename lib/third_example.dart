import 'dart:convert';

import 'package:api_learning/Models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelCreationExample extends StatefulWidget {
  const ModelCreationExample({Key? key}) : super(key: key);

  @override
  State<ModelCreationExample> createState() => _ModelCreationExampleState();
}

class _ModelCreationExampleState extends State<ModelCreationExample> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('API TUTORIAL'),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ReusableRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusableRow(
                                    title: 'username',
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReusableRow(
                                    title: 'email',
                                    value:
                                        snapshot.data![index].email.toString()),
                                ReusableRow(
                                    title: 'Address',
                                    value: snapshot.data![index].address!.city
                                        .toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ]),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
