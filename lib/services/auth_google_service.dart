import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogleService {
  // Google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      // begin interactive sign in process
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      
      // obtain auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      
      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

    // sign in to firebase with the google user credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign-In failed: $e');
      return null;
    }
  }
}