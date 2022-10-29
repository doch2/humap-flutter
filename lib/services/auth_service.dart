import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao_flutter_lib;
import 'package:get/get.dart' hide Response;

import '../models/user.dart';
import '../routes/routes.dart';
import 'firestore_database.dart';
import 'toast.dart';

class AuthService extends GetxController{
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();
  Dio _dio = Get.find<Dio>();
  HumapToast _humapToast = HumapToast();

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
      isLogin = true;
      _userModel.value = await FirestoreDatabase().getUser(firebaseUser!.uid);
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
    Get.offAndToNamed(PageRoutes.PRIVACYPOLICYAGREE);
  }

  signInWithKakao() async {
    try {
      final installed = await kakao_flutter_lib.isKakaoTalkInstalled();
      kakao_flutter_lib.OAuthToken loginToken = installed
          ? await kakao_flutter_lib.UserApi.instance.loginWithKakaoTalk()
          : await kakao_flutter_lib.UserApi.instance.loginWithKakaoAccount();

      kakao_flutter_lib.User kakaoUser = await kakao_flutter_lib.UserApi.instance.me();

      loginUserInfo["type"] = "K";
      loginUserInfo["userid"] = "kakao:${kakaoUser.id}";
      loginUserInfo["email"] = kakaoUser.kakaoAccount!.email;
      loginUserInfo["name"] = kakaoUser.kakaoAccount!.profile!.nickname;
      loginUserInfo["profileImgUrl"] = kakaoUser.kakaoAccount!.profile!.profileImageUrl;

      _humapToast.showToast("카카오 로그인 중입니다.\n카카오톡 연동에 시간이 걸리니 잠시만 기다려주세요.");
      print(loginToken.accessToken);

      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('kakaoToken');
      final resp = await callable.call(<String, dynamic>{
        'access_token': loginToken.accessToken,
      });

      UserCredential _authResult = await FirebaseAuth.instance.signInWithCustomToken(resp.data['result']);

      if (await _firestoreDatabase.isAlreadyRegisterUser(loginUserInfo["userid"])) {
        user = await _firestoreDatabase.getUser(loginUserInfo["userid"]);
      } else {
        await writeAccountInfo();
      }
      isLogin = true;
      Get.toNamed(PageRoutes.PRIVACYPOLICYAGREE);
    } catch (e) {
      if (e.toString().contains("User canceled login.")) {
        _humapToast.showToast("카카오 로그인을 취소하셨습니다.");
      } else {
        print(e);
      }
    }
  }

  logOut() async {
    try {
      await authInstance.signOut();

      userModelClear();

      isLogin = false;

      HumapToast().showToast("로그아웃 되었습니다.");
      Get.offAndToNamed(PageRoutes.LOGIN);
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