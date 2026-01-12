import '../constants/post/post.dart';

// Global posts list
List<PostData> posts = [];

// Find a post by its ID
PostData? findPostById(String id) {
  try {
    return posts.firstWhere((p) => p.headerData.postId == id);
  } catch (_) {
    return null;
  }
}
