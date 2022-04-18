import 'package:example/Api/Models/Post.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<List<Post>> getposts({String? str, DateTime? dateTime}) async {
    final response;
    if (str == null && dateTime == null) {
      response = await http.get(Uri.parse('https://localhost:7135/Posts/GetAllPosts'));
    } else if (str == null) {
      String datetimestring = dateTime.toString();
      response = await http.get(Uri.parse("https://localhost:7135/Posts/GetPostsByDate/$datetimestring"));
    } else if (dateTime == null) {
      response = await http.get(Uri.parse("https://localhost:7135/Posts/GetPostsByTherapistNameSurname/$str"));
    } else {
      var response1 = await http.get(Uri.parse("https://localhost:7135/Posts/GetPostsByTherapistNameSurname/$str"));
      String datetimestring = dateTime.toString();
      var response2 = await http.get(Uri.parse("https://localhost:7135/Posts/GetPostsByDate/$datetimestring"));
      if (response1.statusCode == 200 && response2.statusCode == 200) {
        List<Post> posts = List.empty();
        List<Post> posts1 = Post.listfromJson(response1.body);
        List<Post> posts2 = Post.listfromJson(response2.body);
        for (var item in posts1) {
          if (posts2.any((element) => element.Content == item.Content && element.Title == item.Title && element.Topic == item.Topic && element.dateTime == item.dateTime)) {
            posts.add(item);
          }
        }
        return posts;
      } else {
        throw Exception("Hata");
      }
    }
    if (response.statusCode == 200) {
      return Post.listfromJson(response.body);
    } else {
      throw Exception("Hata");
    }
  }
}
