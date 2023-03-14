import 'package:flutter/material.dart';

import '../widget/widget.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/signIn';

  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
      ),
    );
  }
}
