import 'package:example/Api/Models/BaseUser.dart';
import 'dart:convert';
import 'TherapistMessage.dart';

class Therapist extends BaseUser {
  Therapist({required this.TherapistId, required this.Name, required this.Surname, required this.EMail, required this.Adres, required this.il, required this.ilce, this.therapistmessages, this.Telefon});
  final int TherapistId;
  final String Name;
  final String Surname;
  final String EMail;
  String? Telefon;
  final String Adres;
  final String il;
  final String ilce;
  List<TherapistMessage>? therapistmessages;
  static FromJson(Map<String, dynamic> json) {
    return Therapist(TherapistId: json['therapistId'], Name: json['name'], Surname: json['surname'], EMail: json['eMail'], Telefon: json['telefon'], Adres: json['adres'], il: json['İl'], ilce: json['İlçe'], therapistmessages: TherapistMessage.listfromJson(json['therapistMessages']));
  }

  static listfromJson(Jsonarray) {
    final List<dynamic> dynamicList = jsonDecode(Jsonarray);
    return List<Therapist>.from(dynamicList.map((e) => Therapist.FromJson(e)));
  }
}
