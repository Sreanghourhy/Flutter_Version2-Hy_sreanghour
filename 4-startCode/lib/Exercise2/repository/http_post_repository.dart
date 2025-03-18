import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import 'post_repository.dart';

class HttpPostRepository implements PostRepository {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client _client;

  HttpPostRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<Post>> getPost(int postId) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/posts/$postId'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => fromJson(json)).toList();
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

  Future<List<Post>> getAllPosts() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  Post fromJson(Map<String, dynamic> json) {
    assert(json.containsKey('id'), 'Missing required field: id');
    assert(json['id'] is int, 'Field id must be an integer');

    assert(json.containsKey('title'), 'Missing required field: title');
    assert(json['title'] is String, 'Field title must be a string');

    assert(json.containsKey('body'), 'Missing required field: body');
    assert(json['body'] is String, 'Field body must be a string');

    assert(json.containsKey('userId'), 'Missing required field: userId');
    assert(json['userId'] is int, 'Field userId must be an integer');

    if (!json.containsKey('id') ||
        !json.containsKey('title') ||
        !json.containsKey('body') ||
        !json.containsKey('userId')) {
      throw FormatException('Missing required field in Post JSON');
    }

    if (json['id'] is! int) {
      throw FormatException('Field id must be an integer');
    }

    if (json['userId'] is! int) {
      throw FormatException('Field userId must be an integer');
    }

    if (json['title'] is! String) {
      throw FormatException('Field title must be a string');
    }

    if (json['body'] is! String) {
      throw FormatException('Field body must be a string');
    }

    return Post(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }
}
