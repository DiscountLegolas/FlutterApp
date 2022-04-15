import 'dart:js';

import 'package:example/Api/Models/Post.dart';
import 'package:provider/provider.dart';
import 'package:example/Provider/Models/PostsModel.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kekemelik Therapist App"),
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
        body: PostsGrid());
  }
}

class PostsGrid extends StatelessWidget {
  PostsGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var post = context.watch<PostsModel>();
    // TODO: implement build
    return Column(children: <Widget>[
      TextField(
        keyboardType: TextInputType.text,
        onSubmitted: (String str) {
          post.GetByNameSurname(str);
        },
      ),
      Container(
          height: MediaQuery.of(context).size.height / 2,
          child: FutureBuilder(
              future: post.posts,
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
              }))
    ]);
  }
}
