import 'package:blackcoffer/utils/utiles.dart';
import 'package:blackcoffer/utils/widgets/custom_logo.dart';
import 'package:blackcoffer/utils/widgets/round_button.dart';
import 'package:blackcoffer/views/login_with_phone/verfiy_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final phoneNumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login '),
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
              controller: phoneNumberController,

              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return 'Enter number please ';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter mobile number',
                suffixIcon: Icon(Icons.phone_iphone),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            RoundButton(
                title: 'Next',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (error) {
                        setState(() {
                          loading = false;
                        });
                        Utils().tostMessage(message: error.toString());
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerfiyCode(
                              verificationId: verificationId,
                            ),
                          ),
                        );
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (error) {
                        Utils().tostMessage(message: error.toString());
                      });
                }),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
