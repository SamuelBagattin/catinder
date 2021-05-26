import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<User> signInWithGoogle(BuildContext context) async {
  User user;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
  }

  return user;
}

User getCurrentUser() {
  return auth.currentUser;
}
