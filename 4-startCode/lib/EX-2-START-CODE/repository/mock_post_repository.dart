// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../model/post.dart';
// import './http_post_repository.dart';

// class MockPostRepository extends PostRepository {
//   @override
//   Future<List<Post>> getPost() async {
//     try {
//       final response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to fetch posts');
//       }
//     } catch (e) {
//       Exception("Error fetching data: $e");
//       return [];
//     }
//   }
// }
