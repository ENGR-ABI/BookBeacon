import 'package:bookbeacon/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bookbeacon/app/services/app_preferences.dart';
import 'package:bookbeacon/app/services/instances.dart';

class AuthController extends GetxService {
  final Stream<User?> _authStateChanges =
      FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStateChanges => _authStateChanges;
  late User? _currentUser;
  late UserModel _currentUserInfo;
  User? get currentUser => _currentUser;
  UserModel get currentUserInfo => _currentUserInfo;


  @override
  void onInit() {
    _currentUserInfo = UserModel();
    _authStateChanges.listen((user) {
      _currentUser = user;
    });
    super.onInit();
  }

  @override
  void onReady() async {
    if (currentUserInfo.toMap().isEmpty) {
      await initAuth();
    }
    super.onReady();
  }

  Future<void> fetchCurrentUserInfo(User? user) async {
    // if (user != null) {
    //   await firestore.collection('Qurraa').doc(user.uid).get().then((qaaria) {
    //     if (qaaria.exists) {
    //       _currentUserInfo = UserModel.fromJson(qaaria);
    //       Get.offAllNamed('/private/dashboard');
    //     } else {
    //       Get.offAllNamed('/auth/personalinfo');
    //     }
    //   }, onError: (e) {});
    // } else {
    //   await appController.launchAppropriateScreen();
    // }
  }

  Future<void> initAuth() async {
    await fetchCurrentUserInfo(currentUser);
  }

  Future<bool> checkIfValueExists(
      {required String reference,
      required String field,
      required String value}) async {
    final collectionRef = firestore.collection(reference);
    return collectionRef.where(field, isEqualTo: value).get().then(
      (QuerySnapshot doc) {
        if (doc.docs.isNotEmpty) {
          return true;
        }
        return false;
      },
      onError: (e) {
        return true;
      },
    );
  }

  Future<List<String>?> checkIfValuesExists(
      String reference, String field, List<String> values) async {
    final collectionRef = firestore.collection(reference);
    return collectionRef.where(field, whereIn: values).get().then(
      (QuerySnapshot doc) {
        if (doc.docs.isNotEmpty) {
          final usernames = <String>[];
          for (var doc in doc.docs) {
            usernames.add(doc.get('username'));
          }
          for (var username in usernames) {
            values.removeWhere((element) => element == username);
          }
          return values;
        } else {
          return values;
        }
      },
      onError: (e) {
        return null;
      },
    );
  }

  Future<void> signOut() async {
    // appController.showQuestionDialog(
    //     title: 'Sign Out?',
    //     message: 'Are you sure you want to sign out?',
    //     onConfirm: () async {
    //       await getOutAndNotify();
    //     });
  }

  Future<void> getOutAndNotify() async {
    try {
      await AppPreferences.addPrefs({'isLogged': false});
      await firebaseAuth.signOut();
      Get.offAllNamed('/homepage');
    } catch (_) {}
  }
}
