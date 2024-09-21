import 'package:cloud_firestore/cloud_firestore.dart';

var paystackFundingApi = 'https://api.paystack.co/transaction/initialize';
String paystackSecretKey = 'sk_test_a8973c59cfe25d76b49fe81d0047eb4d5cc53743';
var paystackVerifyApi = 'https://api.paystack.co/transaction/initialize';

//DATABASE:FIRESTORE
//Future<Stream<double>> getBalance() async {
//User? user = FirebaseAuth.instance.currentUser;
//final firestore = FirebaseFirestore.instance;
//if (user != null) {
//DocumentReference userDocRef = firestore.collection('users').doc(user.uid);
//return userDocRef.snapshots().map((docSnapshot) {
//if (docSnapshot.exists) {
//return docSnapshot.get('balance');
//} else {
//return 0.00;
//}
//});
//} else {
//return Stream.error('0.00');
//}
//}

//Future<Stream> getName() async {
//final user = FirebaseAuth.instance.currentUser;
//final firestore = FirebaseFirestore.instance;
//if (user != null) {
//DocumentReference userDocRef = firestore.collection('users').doc(user.uid);
//return userDocRef.snapshots().map((docSnapshot) {
//if (docSnapshot.exists) {
//return docSnapshot.get('name');
//} else {
//return null;
//}
//});
//} else {
//return Stream.error('user');
//}
//}

//DATA SERVICE
class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return User.fromFirestore(snapshot);
      } else {
        throw Exception('Loading');
      }
    }).asBroadcastStream();
  }
}

//USER MODEL
class User {
  late final String username;
  late final double balance;

  User({required this.username, required this.balance});
  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      username: data['username'] ?? '',
      balance: data['balance']?.toDouble() ?? 0.0,
    );
  }
}