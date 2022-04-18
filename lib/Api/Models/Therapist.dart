import 'package:example/Api/Models/BaseUser.dart';
import 'package:example/main.dart';
import 'dart:convert';
import 'TherapistMessage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  static Card TherapistCard(data, context) {
    return Card(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TherapistPage(therapist: data),
                  ));
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(data.Name + " " + data.Surname),
                    Row(
                      children: <Widget>[
                        Text("${data.il}"),
                        const Spacer(),
                        Text("${data.ilce}")
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
