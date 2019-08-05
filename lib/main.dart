import 'package:flutter/material.dart';
import 'views/monitor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
          // This is the theme of your application.
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red),
      home: MyHomePage('Pokedex FTR'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage(this.title);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
          bottom: TabBar(

            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.list,
                ),
                text: 'Pokemones',
              ),
              Tab(
                icon: Icon(
                  Icons.attach_file,
                ),
                text: 'Last pokemon',
              ),
              Tab(
                icon: Icon(
                  Icons.landscape,
                ),
                text: 'Areas',
              )
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(1.0),
          child: TabBarView(
            children: <Widget>[
              Monitor(),
              Container(),
              Text('hola')
            ],
          ),
        ),
        backgroundColor: Colors.red[800],
      ),
    );
  }
}
