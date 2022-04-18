import 'package:example/Api/Models/Therapist.dart';
import 'package:example/Api/http.dart';
import 'package:flutter/foundation.dart';

class TherapistsModel extends ChangeNotifier {
  late Future<List<Therapist>> _therapists;
  PostsModel() {
    this.settherapists = HttpHelper.gettherapists();
  }

  Future<List<Therapist>> get therapists => _therapists;
  set settherapists(Future<List<Therapist>> newtherapists) {
    _therapists = newtherapists;
    notifyListeners();
  }

  void GetTherapistsByNameSurname(String str) {
    if (str.length <= 0) {
      this.settherapists = HttpHelper.gettherapists();
    } else {
      this.settherapists = HttpHelper.gettherapists(str: str);
    }
  }
}
