import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:humap/services/app_first_run.dart';
import 'package:humap/token_reference.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'services/auth_service.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  KakaoSdk.init(
    nativeAppKey: TokenReference.KAKAONATIVEKEY,
    javaScriptAppKey: TokenReference.KAKAOJAVASCRIPTKEY
  );

  Get.put(AppFirstRun(isAppFirstRun: (await IsFirstRun.isFirstRun())));
  Get.lazyPut(() => Dio());
  Get.lazyPut(() => FlutterSecureStorage());
  Get.put<AuthService>(AuthService(), permanent: true);


  runApp(
    GetMaterialApp(
      title: 'HuMap',
      initialRoute: PageRoutes.HOME,
      getPages: SinibankPages.pages,
      debugShowCheckedModeBanner: true
    ),
  );
}