import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../routes/routes.dart';
import 'firestore_database.dart';
import 'toast.dart';

class AuthService extends GetxController{
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();

  Rxn<User> _firebaseUser = Rxn<User>();
  User? get firebaseUser => _firebaseUser.value;
  final Rx<UserModel> _userModel = UserModel().obs;
  UserModel get user => _userModel.value;
  Rx<UserModel> get userModel => _userModel;

  set user(UserModel value) => _userModel.value = value;

  bool isLogin = false;

  Map loginUserInfo = {};

  @override
  onInit() async {
    super.onInit();

    _firebaseUser.bindStream(authInstance.authStateChanges());
    _firebaseUser.value = authInstance.currentUser;

    if (firebaseUser != null) {
      _userModel.value = await FirestoreDatabase().getUser(firebaseUser!.uid);
      isLogin = true;
      Get.toNamed(PageRoutes.HOME);
    }
  }

  userModelClear() {
    _userModel.value = UserModel();
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential _authResult =
    await FirebaseAuth.instance.signInWithCredential(credential);

    loginUserInfo["userid"] = _authResult.user?.uid;
    loginUserInfo["email"] = googleUser?.email;
    loginUserInfo["name"] = googleUser?.displayName;

    if (await _firestoreDatabase.isAlreadyRegisterUser(loginUserInfo["userid"])) {
      //await _apiProvider.userLogin("google", loginUserInfo["userid"]);
      user = await _firestoreDatabase.getUser(loginUserInfo["userid"]);
    } else {
      await writeAccountInfo();
    }
    isLogin = true;
    Get.toNamed(PageRoutes.HOME);
  }

  logOut() async {
    try {
      await authInstance.signOut();

      userModelClear();

      isLogin = false;

      HumapToast().showToast("로그아웃 되었습니다.");
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "로그아웃 오류",
        e.message ?? "예기치 못한 오류가 발생하였습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  writeAccountInfo() async {
    UserModel _user = UserModel(
        id: loginUserInfo["userid"],
        email: loginUserInfo["email"],
        name: loginUserInfo["name"],
    );

    await _firestoreDatabase.createNewUser(_user);
    _userModel.value = _user;
  }
}