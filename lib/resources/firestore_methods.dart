import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Upload post
  Future<String?> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    try {
      final String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      final String postId =
          const Uuid().v1(); // creates unique id based on time

      final Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
    } on FirebaseException catch (error) {
      return parseFirebaseError(error.toString());
    } catch (err) {
      return err.toString();
    }

    return null;
  }

  Future<String?> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } on FirebaseException catch (error) {
      return parseFirebaseError(error.toString());
    } catch (err) {
      return err.toString();
    }

    return null;
  }
}
