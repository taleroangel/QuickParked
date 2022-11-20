import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_parked/widgets/credentials_field.dart';
import 'package:quick_parked/widgets/quickparked_logo.dart';
import 'package:flutter/foundation.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  void attemptCreate(BuildContext context, String email, String password) =>
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("La cuenta ha sido creada con éxito!"),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.of(context).pop();
      })
          // Show error
          .catchError((e) {
        log("Failed account creation", level: DiagnosticLevel.error.index);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text.rich(TextSpan(children: [
            const TextSpan(
                text: "No se ha podido crear la cuenta\n",
                style: TextStyle(color: Colors.red)),
            TextSpan(text: e.message)
          ])),
          behavior: SnackBarBehavior.floating,
        ));
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: defaultTargetPlatform == TargetPlatform.android
            ? null
            : AppBar(
                title: const Text("Registro"),
              ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const QuickParkedLogo(),
            const SizedBox(
              height: 30,
            ),
            CredentialsField(
              legalCheck: true,
              title: "Regístrate",
              submitLabel: "Registrarse",
              onSubmit: (email, password) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Estamos creando tu cuenta, espera un momento..."),
                  behavior: SnackBarBehavior.floating,
                ));

                attemptCreate(context, email, password);
              },
            ),
          ]),
        ),
      );
}
