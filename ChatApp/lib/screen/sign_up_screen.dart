import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../error/error.dart';
import '../provider/provider.dart';
import '../util/util.dart';
import '../widget/widget.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signUp';

  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  late String _username;
  late String _email;
  late String _password;
  File? _imageFile;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sign up',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SignUpProfileImage(setImageFile: setImageFile),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter name',
                      labelText: 'name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (String? name) {
                      if (name == null || name == '') {
                        return 'Enter name ...';
                      }
                    },
                    onSaved: (String? name) {
                      _username = name!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                      labelText: 'email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (String? email) {
                      if (email == null || email == '') {
                        return 'Enter email ...';
                      }
                    },
                    onSaved: (String? email) {
                      _email = email!;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter password',
                      labelText: 'password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (String? password) {
                      if (password == null || password == '') {
                        return 'Enter password ...';
                      }
                    },
                    onSaved: (String? password) {
                      _password = password!;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Confirm password',
                      labelText: 'confirm password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (String? password) {
                      if (password == null || password == '') {
                        return 'Enter password again...';
                      }

                      if (_textEditingController.text != password) {
                        return 'Passwords not match';
                      }

                      return null;
                    },
                    onSaved: (String? password) {
                      _password = password!;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    form.save();

    try {
      await context.read<AuthProvider>().signUp(
            username: _username,
            email: _email,
            password: _password,
            imageFile: _imageFile,
          );
    } on CustomError catch (exception) {
      errorDialog(context: context, customError: exception);
    }
  }

  void setImageFile(File imageFile) {
    _imageFile = imageFile;
  }
}
