import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/data_view.dart';
import 'view_model/data_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  void initState() {
    DataView();

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DataViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DataView(),
      ),
    );
  }
}