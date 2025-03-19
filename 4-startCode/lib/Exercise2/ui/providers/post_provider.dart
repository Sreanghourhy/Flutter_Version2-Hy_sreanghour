import 'package:flutter/material.dart';
import '../../model/post.dart';
import '../../repository/post_repository.dart';
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _repository;
  AsyncValue<List<Post>>? postValue;

  PostProvider({required PostRepository repository}) : _repository = repository;

  void fetchPost(int postId) async {
    postValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Post> posts = await _repository.getPost();
      postValue = AsyncValue.success(posts);
    } catch (error) {
      postValue = AsyncValue.error(error);
    }
    notifyListeners();
  }
}
