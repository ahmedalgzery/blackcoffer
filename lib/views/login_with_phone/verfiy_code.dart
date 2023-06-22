// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:blackcoffer/utils/utiles.dart';
import 'package:blackcoffer/utils/widgets/custom_logo.dart';
import 'package:blackcoffer/utils/widgets/round_button.dart';
import 'package:blackcoffer/views/post_screen/post_views.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerfiyCode extends StatefulWidget {
  const VerfiyCode({super.key, required this.verificationId});
  final verificationId;
  @override
  State<VerfiyCode> createState() => _VerfiyCodeState();
}

class _VerfiyCodeState extends State<VerfiyCode> {
  final smsNumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verfiy Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            const CustomLogo(),
            const Spacer(
              flex: 1,
            ),
            TextFormField(
              controller: smsNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter OPT',
                  suffixIcon: Icon(Icons.phone_iphone)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.035,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Did not get OPT , '),
              TextButton(onPressed: () {}, child: const Text('resend?'))
            ]),
            const Spacer(
              flex: 1,
            ),
            RoundButton(
              title: 'Verfiy',
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: smsNumberController.text.toString());
                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VideosView(),
                    ),
                  );
                } catch (e) {
                  setState(() {
                    loading = true;
                  });
                  Utils().tostMessage(
                    message: e.toString(),
                  );
                }
              },
              loading: loading,
            ),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
