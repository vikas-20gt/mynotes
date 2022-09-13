import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/firebase_options.dart';

class Register_view extends StatefulWidget {
  Register_view({Key? key}) : super(key: key);

  @override
  State<Register_view> createState() => _Register_viewState();
}

class _Register_viewState extends State<Register_view> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: true,
                    decoration:
                        InputDecoration(hintText: 'Enter your email here'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: true,
                    decoration:
                        InputDecoration(hintText: 'Enter your Password here'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        print(userCredential);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('weak password');
                        } else if (e.code == 'email-already-in-use') {
                          print('email is already in use');
                        } else if (e.code == 'invalid-email') ;
                        print('Invalid email');
                      }
                    },
                    child: Text('Register'),
                  ),
                ],
              );
  }
}
