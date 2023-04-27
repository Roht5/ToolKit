import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toolkit/firebase/widget_tree.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    print('Sign in');
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WidgetTree(),
          ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WidgetTree(),
          ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 25, 85, 134)),
      onPressed: () => isLogin
          ? signInWithEmailAndPassword()
          : createUserWithEmailAndPassword(),
      child: Text(
        isLogin ? 'Login' : 'Register',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin ? 'Register Instead' : 'Login Instead',
        style: const TextStyle(color: Color.fromARGB(255, 25, 85, 134)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 25, 85, 134),
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: <Widget>[
              // Lottie.asset(
              //   'assets/loginPage.json',
              //   width: MediaQuery.of(context).size.width / 2,
              //   repeat: true,
              // ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _controllerEmail,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  obscureText: true,
                  controller: _controllerPassword,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
                ),
              ),
              _errorMessage(),
              _submitButton(),
              _loginOrRegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}
