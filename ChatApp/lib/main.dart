import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'provider/provider.dart';
import 'screen/screen.dart';
import 'service/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<firebaseAuth.User?>(
          create: (context) => firebaseAuth.FirebaseAuth.instance.userChanges(),
          // create: (context) => context.read<AuthRepository>().user,
          initialData: null,
        ),
        StateNotifierProvider<AuthProvider, AuthState>(
          create: (context) => AuthProvider(
            firebaseAuthService: FirebaseAuthService(),
            firebaseAuthentication: firebaseAuth.FirebaseAuth.instance,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          ChatRoomsScreen.routeName: (context) => const ChatRoomsScreen(),
          ChatDetailScreen.routeName: (context) => const ChatDetailScreen(),
        },
      ),
    );
  }
}
