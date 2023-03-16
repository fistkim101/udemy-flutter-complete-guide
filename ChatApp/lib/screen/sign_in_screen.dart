import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../error/error.dart';
import '../provider/provider.dart';
import '../screen/screen.dart';
import '../widget/widget.dart';
import '../util/util.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/signIn';

  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                        return 'Enter name ...';
                      }
                    },
                    onSaved: (String? email) {
                      _email = email!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
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
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO : 버튼 자체가 Loding.. 되던가 사용자가 제출되고 있음을 알 수 있도록 완성도 높히기
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
      await context.read<AuthProvider>().signIn(
            email: _email,
            password: _password,
          );
    } on CustomError catch (exception) {
      errorDialog(context: context, customError: exception);
    }
  }
}
