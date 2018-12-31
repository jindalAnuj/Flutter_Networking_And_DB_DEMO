import 'dart:convert';

import 'package:api_to_db_flutter/models/Photo.dart';
import 'package:api_to_db_flutter/models/PhotoDb.dart';
import 'package:api_to_db_flutter/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class FetchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FetchScreenState();
  }
}

class FetchScreenState extends State<FetchScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Photo> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://jsonplaceholder.typicode.com/photos?_limit=10");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      updateListView();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme
              .of(context)
              .accentColor,
          child: new Icon(
            Icons.arrow_downward,
            color: Colors.white,
          ),
          onPressed: () => _fetchData(),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index].title),
                    leading: CircleAvatar(
                        child: new Image.network(
                          list[index].thumbnailUrl,
                          height: 40.0,
                          width: 40.0,
                        )),
                  ));
            }));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      for (int i = 0; i < list.length; i++) {
        Future<int> noteListFuture = databaseHelper.insertNote(
            PhotoDb.withId(list[i].id, list[i].title, list[i].thumbnailUrl));
        print('Check $i');
      }
      _showSnackBar(context, 'Data Saved to  Db Records Screen');
    });
  }
}
