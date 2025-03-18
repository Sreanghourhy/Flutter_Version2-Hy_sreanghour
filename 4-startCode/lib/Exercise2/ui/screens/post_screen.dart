import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1 - Get the post provider
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            // 2- Fetch posts
            onPressed: () => {postProvider.fetchPost()},
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      // 3 - Display the posts
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider postProvider) {
    final postValue = postProvider.postValue;

    // Case 1: No async data yet
    if (postValue == null) {
      return const Text('Tap refresh to display posts');
    }

    // Case 2: Handle different states
    switch (postValue.state) {
      case AsyncValueState.loading:
        return const CircularProgressIndicator();

      case AsyncValueState.error:
        return Text('Error: ${postValue.error}');

      case AsyncValueState.success:
        // Case 3: Empty list
        if (postValue.data!.isEmpty) {
          return const Text('No posts available');
        }

        // Case 4: Display list of posts
        return ListView.builder(
          itemCount: postValue.data!.length,
          itemBuilder: (context, index) {
            return PostCard(post: postValue.data![index]);
          },
        );
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
      ),
    );
  }
}
