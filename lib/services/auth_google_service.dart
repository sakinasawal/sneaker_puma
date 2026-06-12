import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

class AuthGoogleService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      final result = await _firebaseAuth.signInWithCredential(credential);
      developer.log(  
        'Firebase Sign In Success — Firebase email: ${result.user?.email}, uid: ${result.user?.uid}',
        name: 'AuthGoogleService',
      );
      
      return result;
    } catch (e) {
      developer.log(
        'Google Sign-In failed',
        name: 'AuthGoogleService',
        error: e,
      );
      rethrow;
    }
  }
}