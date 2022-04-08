import 'dart:convert';
class UserMessage {
  const UserMessage({required this.dateTime,required this.Body,required this.User1Id,required this.User2Id});
  final String Body;
  final DateTime dateTime;
  final int User1Id;
  final int User2Id;
  static FromJson(Map<String, dynamic> json){
    return UserMessage(Body: json['body'], dateTime:DateTime.parse(json['dateTime']) , User1Id: json['user1Id'], User2Id:  json['user2Id']);
  }
  static listfromJson(Jsonarray){
  if (!(Jsonarray is List<dynamic>)) {
      final List<dynamic> dynamicList = jsonDecode(Jsonarray);
      return List<UserMessage>.from(dynamicList.map((e) => UserMessage.FromJson(e)));
    }
  return List<UserMessage>.from(Jsonarray.map((e) => UserMessage.FromJson(e)));
  }
}