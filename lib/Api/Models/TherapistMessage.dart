import 'dart:convert';
class TherapistMessage {
  const TherapistMessage({required this.dateTime,required this.Body,required this.UserId,required this.TherapistId});
  final String Body;
  final DateTime dateTime;
  final int UserId;
  final int TherapistId;
  static FromJson(Map<String, dynamic> json){
    return TherapistMessage(Body: json['body'], dateTime:DateTime.parse(json['dateTime']) , UserId: json['userId'], TherapistId:  json['therapistId']);
  }
  static listfromJson(Jsonarray){
    if (!(Jsonarray is List<dynamic>)) {
        final List<dynamic> dynamicList = jsonDecode(Jsonarray);
        return List<TherapistMessage>.from(dynamicList.map((e) => TherapistMessage.FromJson(e)));
    }
    return List<TherapistMessage>.from(Jsonarray.map((e) => TherapistMessage.FromJson(e)));
  }
}