import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/util/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UserRepo {
  Users _user;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _collectionReference =
      _firebaseFirestore.collection(USERS_COLLECTION);

  Users get getUser => _user;

  UserRepo() {
    getUserDetails();
  }
  // Get Current User
  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser;

    return currentUser;
  }

  // Get All User Details
  Future<Users> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _collectionReference.doc(currentUser.uid).get();
    _user = Users.fromMap(documentSnapshot.data());
    return Users.fromMap(documentSnapshot.data());
  }

  // Get User Details by ID
  Future<Users> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _collectionReference.doc(id).get();
      return Users.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign In with Google
  Future<User> signIn(String phone, String name) async {
    var userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: "$phone@innovationcodes.com", password: "Scorpion0107898142");
    } catch (e) {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: "$phone@innovationcodes.com", password: "Scorpion0107898142");
    }

    User user = userCredential.user;

    addDataToDb(user, name);
    return user;
  }

  // Authenticate User
  // ignore: missing_return
  Future<bool> authenticateUser(User user) async {
    Stream<QuerySnapshot> result = _firebaseFirestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .snapshots();

    // final List<DocumentSnapshot> docs = result.docs;
    await for (var data in result) {
      //if user is registered then length of list > 0 or else less than 0
      return data.docs.length == 0 ? true : false;
    }
  }

  // Add Users to Database
  Future<void> addDataToDb(User currentUser, String token) async {
    String username = currentUser.email.split('@')[0];

    Users user = Users(
      uid: currentUser.uid,
      email: currentUser.email,
      name: token,
      profilePhoto: currentUser.photoURL,
      firebaseToken: token,
      username: username,
    );

    _firebaseFirestore
        .collection(USERS_COLLECTION)
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }

  // Fetch All Users
  Future<List<Users>> fetchAllUsers(User currentUser) async {
    List<Users> userList = List<Users>();

    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection(USERS_COLLECTION).get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(Users.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _collectionReference.doc(uid).snapshots();
}
