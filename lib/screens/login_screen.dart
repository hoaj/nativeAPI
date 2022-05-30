import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart';
import 'package:lottie/lottie.dart';
import 'package:local_auth/local_auth.dart';
import 'package:native_api/screens/nfc_screen.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool focus = false;

  Future<void> authenticate(BuildContext context) async {
    bool didAuthenticate = false;
    try {
      didAuthenticate = await LocalAuthentication().authenticate(
        localizedReason:
            'Venligst brug Face ID eller Touch ID til at logge ind på Native Api',
        authMessages: [
          const IOSAuthMessages(
              // cancelButton: 'cancelButton',
              // lockOut: "lockOut",
              // goToSettingsButton: "goToSettingsButton",
              // goToSettingsDescription: "goToSettingsDescription",
              )
        ],
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) {
              return const NFCScreen();
            },
          ),
        );
      } else {
        setState(() {
          focus = true;
        });
      }
    } on PlatformException catch (err) {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.90,
            child: Column(
              children: [
                const Spacer(
                  flex: 6,
                ),
                Flexible(
                  flex: 11,
                  child: LottieBuilder.asset('assets/movie.json'),
                ),
                const Spacer(
                  flex: 2,
                ),
                // const FittedBox(
                //   fit: BoxFit.fitWidth,
                //   child: Text(
                //     'Sign-in to access the site',
                //     style: TextStyle(fontSize: 23),
                //   ),
                // ),
                const Spacer(),
                CupertinoTextField(
                  key: UniqueKey(),
                  autofocus: focus,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  placeholder: "E-mail",
                ),
                const Spacer(),
                const CupertinoTextField(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  placeholder: "Password",
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return const NFCScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('LOGIN'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        shape: const RoundedRectangleBorder(),
                        minimumSize: const Size(250.00, 70.00),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        authenticate(context);
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset("assets/faceid.png"),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
