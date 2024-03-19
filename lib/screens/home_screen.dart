import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_get_api_call_with_null_safety/models/get_api_model.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<GetAPIModel> dataList = [];
  Future<List<GetAPIModel>> getAPIModel() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      dataList.clear();
      for (Map<String, dynamic> i in data) {
        dataList.add(GetAPIModel.fromJson(i));
      }
      return dataList;
    } else {
      return dataList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Home Page",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getAPIModel(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "id: ${dataList[index].id}",
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(dataList[index].title.toString()),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(dataList[index].body.toString()),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
