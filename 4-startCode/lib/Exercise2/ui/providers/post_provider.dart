import 'package:flutter/material.dart';
import '../../model/post.dart';
import '../../repository/post_repository.dart';
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _repository;

  AsyncValue<List<Post>>? postValue;

  PostProvider({required PostRepository repository}) : _repository = repository;

  void fetchPost() async {
    // 1️⃣ Set loading state
    postValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2️⃣ Fetch the data
      Post post = await _repository.getPost(1); // Assuming 1 is the required argument

      // 3️⃣ Set success state with a List<Post>
      postValue = AsyncValue.success([post]);
    } catch (error) {
      // 4️⃣ Set error state
      postValue = AsyncValue.error(error);
    }

    notifyListeners();
  }
}
