import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  AuthProvider() {
    _setAuthStateListener();
    _signInIfNotSignedIn();
  }

  Future<FirebaseUser> currentUser() async {
    await _signInIfNotSignedIn();
    return _user;
  }

  get onAuthStateChanged => _auth.onAuthStateChanged;

  void _setAuthStateListener() {
    _auth.onAuthStateChanged.listen((user) => _user = user);
  }

  Future<void> _signInIfNotSignedIn() async {
    final user = await _auth.currentUser();
    if (user == null) {
      await _auth.signInAnonymously();
    }
    _user = await _auth.currentUser();
  }
}
