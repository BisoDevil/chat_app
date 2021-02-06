import 'package:chat_app/app/data/model/message.dart';
import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/util/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRepo {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final CollectionReference _messageCollection =
      _firebaseFirestore.collection(MESSAGES_COLLECTION);

  final CollectionReference _userCollection =
      _firebaseFirestore.collection(USERS_COLLECTION);

  Future<void> addMessageToDb(
      Message message, Users sender, Users receiver) async {
    var map = message.toMap();

    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToContacts(senderId: sender, users: receiver);

    return await _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  DocumentReference getContactsDocument({String of, String forContact}) =>
      _userCollection.doc(of).collection(CONTACTS_COLLECTION).doc(forContact);

  addToContacts({Users senderId, Users users}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId.uid, users, currentTime);
    await addToReceiverContacts(senderId, users.uid, currentTime);
  }

  Future<void> addToSenderContacts(
    String senderId,
    Users users,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: users.uid).get();

    if (!senderSnapshot.exists) {
      //does not exists

      var receiverMap = users.toMap(users);

      await getContactsDocument(of: senderId, forContact: users.uid)
          .set(receiverMap);
    }
  }

  Future<void> addToReceiverContacts(
    Users users,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: users.uid).get();

    if (!receiverSnapshot.exists) {
      //does not exists

      var senderMap = users.toMap(users);

      await getContactsDocument(of: receiverId, forContact: users.uid)
          .set(senderMap);
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) =>
      _userCollection.doc(userId).collection(CONTACTS_COLLECTION).snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      _messageCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
}
