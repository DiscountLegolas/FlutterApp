import 'dart:ffi';

import 'package:example/Api/Models/Post.dart';
import 'package:example/Api/http.dart';
import 'package:example/MobxFiles/Posts.dart';
import 'package:flutter/foundation.dart';

class PostsModel extends ChangeNotifier {
  late Future<List<Post>> _posts;
  PostsModel() {
    _posts = HttpHelper.getposts();
  }
  Future<List<Post>> get posts => _posts;
  set setposts(Future<List<Post>> newposts) {
    _posts = newposts;
    notifyListeners();
  }

  void GetByDateTime(DateTime dateTime) {
    this.setposts = HttpHelper.getposts(dateTime: dateTime);
  }

  void GetByTherapistId(int therapistid) {
    this.setposts = HttpHelper.getposts(therapistid: therapistid);
  }

  void GetByDateTimeTherapistId(DateTime dateTime, int therapistid) {
    this.setposts = HttpHelper.getposts(dateTime: dateTime, therapistid: therapistid);
  }
}
