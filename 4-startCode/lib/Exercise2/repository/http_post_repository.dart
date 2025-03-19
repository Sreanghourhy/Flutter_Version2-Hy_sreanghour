import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/post.dart';
import 'post_repository.dart';

class HttpPostsRepository extends PostRepository {
  static const String url = "https://jsonplaceholder.typicode.com/posts";
  Post fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }

  @override
  Future<List<Post>> getPost() async {
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => fromJson(json)).toList();
      } else {
        throw Exception("Failed to get posts");
      }
    } catch (e) {
      Exception("Failed to get posts");
      return [];
    }
  }
}
