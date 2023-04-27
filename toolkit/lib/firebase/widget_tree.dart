import 'package:flutter/material.dart';
import '../Ui/google_ml_kit.dart';
import 'auth.dart';
import 'login_or_register.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tool Kit'),
            ),
            body: const GoogleMLKitGridView(),
          );
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}
