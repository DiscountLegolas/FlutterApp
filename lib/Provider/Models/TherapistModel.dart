import 'package:example/Api/Models/Therapist.dart';
import 'package:example/Api/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostsModel extends ChangeNotifier {
  late Future<List<Therapist>> _therapists;
  PostsModel() {
    this.settherapists = HttpHelper.gettherapists();
  }
  Future<List<Therapist>> get therapists => _therapists;
  set settherapists(Future<List<Therapist>> newtherapists) {
    print("notified");
    _therapists = newtherapists;
    notifyListeners();
  }

  void GetTherapistsByName(String str) {
    this.settherapists = HttpHelper.gettherapists(str: str);
  }
}
