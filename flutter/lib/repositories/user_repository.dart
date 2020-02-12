import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample/data_providers/auth_provider.dart';
import 'package:sample/data_providers/firestore_provider.dart';
import 'package:sample/models/user.dart';

class UserRepository {
  final _firestoreProfider = FirestoreProvider();
  final _authProvider = AuthProvider();

  Future<User> getUser() async {
    final firebaseUser = await _authProvider.currentUser();
    final userDoc = await _firestoreProfider.getUserDoc(firebaseUser.uid);
    final user = User.fromSnapshot(userDoc);
    return user;
  }

  Future<void> saveUserProfile(User user) {
    return _firestoreProfider.updateProfile(user);
  }

  Stream<FirebaseUser> onAuthStateChanged() {
    return _authProvider.onAuthStateChanged;
  }

  Stream<User> userStream(String uid) {
    return _firestoreProfider.userDocStream(uid).map(User.fromMap);
  }
}
