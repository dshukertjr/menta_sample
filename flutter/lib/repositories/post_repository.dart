import 'package:sample/data_providers/auth_provider.dart';
import 'package:sample/data_providers/firestore_provider.dart';
import 'package:sample/models/post.dart';

class PostRepository {
  final _firestoreProvider = FirestoreProvider();
  final _authProvider = AuthProvider();

  int _postLimit = 10;

  Stream<List<Post>> postsStream() {
    return _firestoreProvider.posts(_postLimit).map<List<Post>>(
        (snapshot) => snapshot.documents.map<Post>(Post.fromSnapshot).toList());
  }
}
