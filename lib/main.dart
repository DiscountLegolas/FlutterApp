import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/Api/http.dart';
import 'package:http/http.dart' as http;
import 'Api/Models/Post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kekemelik Therapist App"),
        ),
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
                    constraints: BoxConstraints(minHeight: 100, maxHeight: (MediaQuery.of(context).size.height / 10) * 9),
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
    final posts = HttpHelper.getposts();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kekemelik Therapist App"),
      ),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(""),
              decoration: BoxDecoration(color: Colors.amber),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home Page"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Therapists"),
            ),
            ListTile(
              leading: Icon(Icons.pageview),
              title: Text("Posts"),
            ),
          ],
        ),
      ),
    );
  }
}
