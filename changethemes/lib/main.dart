import 'dart:async';

import 'package:changethemes/utils/theme1.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darktheme,
      initialData: false,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: 
          //basicTheme1(),
          snapshot.data ? basicTheme() : basicTheme1(),
          home: HomePage(darktheme: snapshot.data),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final bool darktheme;

  const HomePage({Key key, this.darktheme}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Theming'),
      ),
      body: Center(
        child: Text('Dynamic Theming', style:Theme.of(context).textTheme.headline2),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Dark Theme'),
              trailing:
                  Switch(value: widget.darktheme, onChanged: bloc.changetheme),
            )
          ],
        ),
      ),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changetheme => _themeController.sink.add;
  get darktheme => _themeController.stream;
}

final bloc = Bloc();
