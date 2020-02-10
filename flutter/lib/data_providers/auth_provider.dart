import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  AuthProvider() {
    _setAuthStateListener();
    _signInIfNotSignedIn();
  }

  get firebaseUser => _user;

  get onAuthStateChanged => _auth.onAuthStateChanged;

  void _setAuthStateListener() {
    _auth.onAuthStateChanged.listen((user) => _user = user);
  }

  Future<void> _signInIfNotSignedIn() async {
    final user = await _auth.currentUser();
    if (user == null) {
      return _auth.signInAnonymously();
    }
  }
}
