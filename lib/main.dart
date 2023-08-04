import 'package:flutter/material.dart';
import 'package:sql_data_store/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Data Store',
      home: HomePage(),
    );
  }
}

