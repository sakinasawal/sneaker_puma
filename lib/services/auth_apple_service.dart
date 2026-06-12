import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:developer' as developer;

class AuthAppleService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithApple() async {
    try {

      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      developer.log(  
        'Apple User: ${appleIdCredential.email}',
        name: 'AuthAppleService',
      );

      final oAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      if (appleIdCredential.identityToken == null) {
        throw Exception('Apple Sign-In failed: identityToken is null. Try signing out of Apple ID and signing in again.');
      }

      final result = await _firebaseAuth.signInWithCredential(oAuthCredential);
      developer.log(
        'Apple Sign-In Success: ${result.user?.uid}',
        name: 'AuthAppleService',
      );
      return result;
    } catch (e) {
      developer.log(
        'Apple Sign-In failed',
        name: 'AuthAppleService',
        error: e,
      );
      rethrow;
    }
  }
}