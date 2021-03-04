import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/data_db/section_db.dart';
import 'package:sqflite_test/database_helper.dart';
import 'package:sqflite_test/providers/db_provider.dart';

import 'package:sqflite_test/data_db/subject_db.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final tempSubject = SubjectDB(id: 1, unitName: "Algebra");
    final tempSection = SectionDB(id: 1, idSubject: 1, sectionName: "Geometry");
    DBProvider.db.newSubject(tempSubject);
    //leer la data
    // DBProvider.db.getSubjectById(2).then((subject)=> print(subject.unitName));
    //leer toda la data
    // DBProvider.db.getAllSubjects().then(print);
    //delete data
    DBProvider.db.deleteAllSubjects().then(print);

    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLITE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  int i = await DatabaseHelper.instance
                      .insert({DatabaseHelper.columnName: 'Andres'});
                  print('Id inserted: $i');
                },
                child: Text('insert'),
                style: TextButton.styleFrom(backgroundColor: Colors.blue[200])),
            TextButton(
                onPressed: () async {
                  List<Map<String, dynamic>> queryRows =
                      await DatabaseHelper.instance.queryAll();

                  print(queryRows);
                },
                child: Text('query'),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.yellow[200])),
            TextButton(
                onPressed: () async {
                  int updateId = await DatabaseHelper.instance.update({
                    DatabaseHelper.columnId: 2,
                    DatabaseHelper.columnName: 'Ana'
                  });
                  print(updateId);
                },
                child: Text('update'),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.green[200])),
            TextButton(
                onPressed: () async {
                  int rowsEffected = await DatabaseHelper.instance.delete(3);
                  print(rowsEffected);
                },
                child: Text('delete'),
                style: TextButton.styleFrom(backgroundColor: Colors.red[200])),
            TextButton(
                onPressed: () async {
                  int rowsEffected = await DatabaseHelper.instance.delete(3);
                  print(rowsEffected);
                },
                child: Text('read BD '),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.orange[200])),
          ],
        ),
      ),
    );
  }
}
