// import 'package:cloud_firestore/cloud_firestore.dart';


// class FirestoreService {
//   final FirebaseFirestore _firestore;

//   FirestoreService(this._firestore);

//   Future<void> createNewWeight({
//     required Map<String, dynamic> data,
//     required String collectionName,
//     required String doc,
//   }) async {
//     final ref = _firestore.collection(collectionName).doc(doc);
//     await ref.set(data);
//   }

//   // Future<bool> isSignedIn() async {
//   //   bool authStatus = false;
//   //   authStatus.logW('before stream');
//   //   final user = _firestore.currentUser;
//   //   if (user == null) {
//   //     logger.w('User is currently signed out!');
//   //     authStatus = false;
//   //   } else {
//   //     logger.w('User is signed in!');
//   //     authStatus = true;
//   //   }
//   //   // _firebaseAuth.idTokenChanges().listen((User? user) {
//   //   //   if (user == null) {
//   //   //     logger.w('User is currently signed out!');
//   //   //     authStatus = false;
//   //   //   } else {
//   //   //     logger.w('User is signed in!');
//   //   //     authStatus = true;
//   //   //   }
//   //   // });
//   //   authStatus.logW('after stream');
//   //   return authStatus;
//   // }

//   // Future<void> firebaseLogout() async {
//   //   await _firestore.signOut();
//   // }
// }
