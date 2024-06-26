import 'dart:io';

import 'package:navin_project/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum AuthState { Unauthenticated, Authenticated }

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? _user;
  AuthState _authState = AuthState.Unauthenticated;

  AuthService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? get user => _user;
  AuthState get authState => _authState;

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    _authState =
        user == null ? AuthState.Unauthenticated : AuthState.Authenticated;
    notifyListeners();
  }

  Future<String> _uploadProfilePicture(File image) async {
    try {
      Reference storageReference =
          _storage.ref().child('profile_pictures/${_user!.uid}.jpg');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload profile picture. Please try again.');
    }
  }

  Future<void> signUp(
    String firstName,
    String lastName,
    String username,
    String email,
    String gender,
    String phone,
    File? profileImage,
    String whatsApp,
    String filmDept,
    String? role,
    String password,
    String confirmPassword,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        String? profileImageUrl;
        if (profileImage != null) {
          profileImageUrl = await _uploadProfilePicture(profileImage);
        }

        UserModel userModel = UserModel(
          id: user.uid,
          firstName: firstName,
          lastName: lastName,
          username: username,
          email: email,
          gender: gender,
          phone: phone,
          photoUrl: profileImageUrl,
          whatsapp: whatsApp,
          filmDept: filmDept,
          role: role,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _firestore
            .collection('users_profile')
            .doc()
            .set(userModel.toMap());
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserModel?> fetchUserProfile() async {
    if (_user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('users_profile')
          .where('id', isEqualTo: _user!.uid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<void> updateProfile(
    File? profileImage,
    String? bio,
    String? gender,
    String? firstNamee,
    String? lastName,
    String? phone,
  ) async {
    if (_user != null) {
      DocumentSnapshot snapshot =
          await _firestore.collection('users_profile').doc(_user!.uid).get();
      if (snapshot.exists) {
        String? profileImageUrl;
        if (profileImage != null) {
          profileImageUrl = await _uploadProfilePicture(profileImage);
        }

        Map<String, dynamic> updateData = {
          'firstName': firstNamee,
          'phone': phone,
          'lastName': lastName,
          'bio': bio,
          'updatedAt': DateTime.now(),
        };

        if (profileImageUrl != null) {
          updateData['photoUrl'] = profileImageUrl;
        }

        await _firestore
            .collection('users_profile')
            .doc(_user!.uid)
            .update(updateData);
      }
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          DocumentSnapshot userDoc =
              await _firestore.collection('users_profile').doc(user.uid).get();
          if (!userDoc.exists) {
            UserModel userModel = UserModel(
              id: user.uid,
              email: user.email!,
              firstName: user.displayName ?? '',
              phone: user.phoneNumber ?? '',
              gender: '',
              username: '',
              filmDept: '',
              whatsapp: '',
              createdAt: DateTime.now(),
              lastName: '',
            );
            await _firestore
                .collection('users_profile')
                .doc(user.uid)
                .set(userModel.toMap());
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to sign in with Google. Please try again later.');
    }
  }

  Future<void> signOutGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (e) {
      throw Exception(
          'Failed to sign out from Google. Please try again later.');
    }
  }
}
