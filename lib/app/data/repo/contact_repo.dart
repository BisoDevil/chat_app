import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/util/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  Future<void> addContactToDb(Users sender, Users receiver) async {
    addToContacts(sender: sender, receiver: receiver);
  }

  DocumentReference getContactsDocument({String of, String forContact}) =>
      _userCollection.doc(of).collection(CONTACTS_COLLECTION).doc(forContact);

  addToContacts({Users sender, Users receiver}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(sender.uid, receiver, currentTime);
    await addToReceiverContacts(sender, receiver.uid, currentTime);
  }

  Future<void> addToSenderContacts(
    String senderId,
    Users users,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: users.uid).get();

    if (!senderSnapshot.exists) {
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

  Stream<QuerySnapshot> fetchContacts({String userId}) =>
      _userCollection.doc(userId).collection(CONTACTS_COLLECTION).snapshots();
}
