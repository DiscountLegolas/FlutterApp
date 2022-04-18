import 'dart:js';

import 'package:example/Api/Models/Therapist.dart';
import 'package:example/Provider/Models/PostsModel.dart';
import 'package:example/Provider/Models/TherapistModel.dart';
import 'package:example/Provider/Pages/PostsPage.dart';
import 'package:example/Provider/Pages/TherapistsPage.dart';
import 'package:example/login.dart';
import 'package:flutter/material.dart';
import 'package:example/Api/http.dart';
import 'Api/Models/Post.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static AppBar BuildAppBar(context) {
    return AppBar(
      centerTitle: true,
      title: Text("Kekemelik Therapist App"),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(title: "Kekemelik"),
                  ));
            },
            icon: const Icon(Icons.person))
      ],
    );
  }

  static Drawer BuildDrawer(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(""),
            decoration: BoxDecoration(color: Colors.amber),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
            leading: Icon(Icons.home),
            title: Text("Home Page"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TherapistsPage(),
                  ));
            },
            leading: Icon(Icons.person),
            title: Text("Therapists"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsPage(),
                  ));
            },
            leading: Icon(Icons.pageview),
            title: Text("Posts"),
          ),
        ],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PostsModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => TherapistsModel(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.amber,
          ),
          home: MyHomePage(),
        ));
  }
}

class TherapistPage extends StatelessWidget {
  TherapistPage({Key? key, required this.therapist}) : super(key: key);
  final Therapist therapist;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class PostPage extends StatelessWidget {
  PostPage({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: MyApp.BuildAppBar(context),
        body: Card(
            child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text("${post.Topic}"),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(post.Title),
                const SizedBox(height: 20),
                ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 100, maxHeight: (MediaQuery.of(context).size.height / 10) * 6),
                    child: SingleChildScrollView(
                      child: Text(post.Content),
                    )),
                Spacer(),
                Row(
                  children: <Widget>[
                    Text("${post.therapist.Name + " " + post.therapist.Surname}"),
                    const Spacer(),
                    Text("${post.dateTime.day.toString() + "-" + post.dateTime.month.toString() + "-" + post.dateTime.year.toString()}")
                  ],
                )
              ],
            ),
          ),
        )));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key) {}

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    print("Loaded");
    final posts = HttpHelper.getposts();
    // TODO: implement build
    return Scaffold(
      appBar: MyApp.BuildAppBar(context),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              "Popular Posts",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: FutureBuilder(
                future: posts,
                builder: (BuildContext bcontext, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Post.PostCard(snapshot.data[index], context);
                        });
                  }
                }),
          )
        ],
      ),
      drawer: MyApp.BuildDrawer(context),
    );
  }
}
