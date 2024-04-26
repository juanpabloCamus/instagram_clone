import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/utils/constants.dart';
import 'package:instagram_clone/utils/utils.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot documentSnapshot =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromSnap(documentSnapshot);
  // }

  ///Sign Up User
  Future<String?> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      // Register user in auth with email and password
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      model.User user = model.User(
        username: username,
        uid: cred.user!.uid,
        photoUrl: photoUrl,
        email: email,
        bio: bio,
        followers: [],
        following: [],
      );

      // Add user in our database
      await _firestore
          .collection("users")
          .doc(cred.user!.uid)
          .set(user.toJson());

      return null;
    } on FirebaseException catch (error) {
      return parseFirebaseError(error.toString());
    } catch (err) {
      return err.toString();
    }
  }

  ///Logging in user. The response will be null
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // logging in user with email and password
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (error) {
      return parseFirebaseError(error.toString());
    } catch (err) {
      return err.toString();
    }

    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
