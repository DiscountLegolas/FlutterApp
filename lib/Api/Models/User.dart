import 'package:example/Api/Models/UserMessage.dart';

import 'TherapistMessage.dart';
import 'dart:convert';

class User {
  User({required this.UserName, required this.EMail, this.Telefon, this.therapistmessages, this.userMessages});
  final String UserName;
  final String EMail;
  String? Telefon;
  List<TherapistMessage>? therapistmessages;
  List<UserMessage>? userMessages;
  static FromJson(Map<String, dynamic> json) {
    return User(UserName: json['therapistId'], EMail: json['eMail'], Telefon: json['telefon'], userMessages: UserMessage.listfromJson(json['userMessages']), therapistmessages: TherapistMessage.listfromJson(json['therapistMessages']));
  }

  static listfromJson(Jsonarray) {
    final List<dynamic> dynamicList = jsonDecode(Jsonarray);
    return List<User>.from(dynamicList.map((e) => User.FromJson(e)));
  }
}
