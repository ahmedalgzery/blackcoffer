import 'dart:async';

import 'package:blackcoffer/views/login_with_phone/login_with_phone.dart';
import 'package:blackcoffer/views/post_screen/post_views.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideosView(),
                ),
              ));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginWithPhone(),
                ),
              ));
    }
  }
}
