import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BlackcofferFirebaseUser {
  BlackcofferFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

BlackcofferFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BlackcofferFirebaseUser> blackcofferFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BlackcofferFirebaseUser>(
      (user) {
        currentUser = BlackcofferFirebaseUser(user);
        return currentUser!;
      },
    );
