import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:example/main.dart';
import 'Therapist.dart';

class Post {
  const Post({required this.dateTime, required this.therapist, required this.Title, required this.Content, required this.Topic});
  final DateTime dateTime;
  final Therapist therapist;
  final String Title;
  final String Content;
  final String Topic;
  static FromJson(Map<String, dynamic> json) {
    return Post(dateTime: DateTime.parse(json['dateTime']), therapist: Therapist.FromJson(json['therapist']), Title: json['title'], Content: json['content'], Topic: json['topic']);
  }

  static listfromJson(Jsonarray) {
    final List<dynamic> dynamicList = jsonDecode(Jsonarray);
    return List<Post>.from(dynamicList.map((e) => Post.FromJson(e)));
  }

  static Card PostCard(data, context) {
    Widget BuildContent() {
      if (data.Content.length > 200) {
        return Text("${data.Content.substring(0, 50) + "..."}");
      } else {
        return Text(data.Content);
      }
    }

    return Card(
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPage(post: data),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Text("${data.Topic}"),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(data.Title),
                    const SizedBox(height: 20),
                    BuildContent(),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("${data.therapist.Name + " " + data.therapist.Surname}"),
                        const Spacer(),
                        Text("${data.dateTime.day.toString() + "-" + data.dateTime.month.toString() + "-" + data.dateTime.year.toString()}")
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
