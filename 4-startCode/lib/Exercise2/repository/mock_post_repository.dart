import '../model/post.dart';
import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  @override
  Future<Post> getPost(int postId) {
        // Simulate network delay of 5 seconds
    return Future.delayed(Duration(seconds: 5), () {
      if (postId != 25) {
        throw Exception("No post found");
      }
      return Post(
        id: 25,
        title: 'Who is the best',
        description: 'teacher ronan',
      );
    });
  }

  Future<List<Post>> getPosts() {
        // Simulate network delay of 5 seconds and return fake data
    return Future.delayed(Duration(seconds: 5), () {
      return [
        Post(id: 1, title: 'First Post', description: 'This is the first post'),
        Post(
          id: 2,
          title: 'Second Post',
          description: 'This is the second post',
        ),
        Post(id: 3, title: 'Third Post', description: 'This is the third post'),
      ];
    });
  }
}
