// import 'package:anipedia/firebase/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';

// class LoginWindow extends StatefulWidget {
//   const LoginWindow({super.key});

//   @override
//   State<LoginWindow> createState() => _LoginWindowState();
// }

// class _LoginWindowState extends State<LoginWindow> {
//   FocusNode emailFocusNode = FocusNode();
//   TextEditingController emailController = TextEditingController();

//   FocusNode passwordFocusNode = FocusNode();
//   TextEditingController passwordController = TextEditingController();

//   /// rive controller and input
//   StateMachineController? controller;

//   SMIInput<bool>? isChecking;
//   SMIInput<double>? numLook;
//   SMIInput<bool>? isHandsUp;

//   // SMIInput<bool>? trigSuccess;
//   // SMIInput<bool>? trigFail;

//   @override
//   void initState() {
//     emailFocusNode.addListener(emailFocus);
//     passwordFocusNode.addListener(passwordFocus);
//     super.initState();
//   }

//   @override
//   // void dispose() {
//   //   emailFocusNode.removeListener(emailFocus);
//   //   passwordFocusNode.removeListener(passwordFocus);
//   //   super.dispose();
//   // }

//   void emailFocus() {
//     isChecking?.change(emailFocusNode.hasFocus);
//   }

//   void passwordFocus() {
//     isHandsUp?.change(passwordFocusNode.hasFocus);
//   }

//   String? errorMessage = '';
//   bool isLogin = true;

//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   Future<void> signInWithEmailAndPassword() async {
//     print('Sign in');
//     try {
//       await Auth().signInWithEmailAndPassword(
//         email: _controllerEmail.text,
//         password: _controllerPassword.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   Future<void> createUserWithEmailAndPassword() async {
//     try {
//       await Auth().createUserWithEmailAndPassword(
//         email: _controllerEmail.text,
//         password: _controllerPassword.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   Widget _title() {
//     return const Text('Firebase Auth');
//   }

//   Widget _entryField(
//     String title,
//     TextEditingController controller,
//   ) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: title,
//       ),
//     );
//   }

//   Widget _errorMessage() {
//     return Text(errorMessage == '' ? '' : 'Humm? $errorMessage');
//   }

//   Widget _submitButton() {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//           backgroundColor: const Color.fromARGB(255, 25, 85, 134)),
//       onPressed: () => isLogin
//           ? signInWithEmailAndPassword()
//           : createUserWithEmailAndPassword(),
//       child: Text(isLogin ? 'Login' : 'Register'),
//     );
//   }

//   Widget _loginOrRegisterButton() {
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           isLogin = !isLogin;
//         });
//       },
//       child: Text(
//         isLogin ? 'Register Instead' : 'Login Instead',
//         style: const TextStyle(color: Color.fromARGB(255, 25, 85, 134)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(color: Color(0xFFD6E2EA)),
//           width: double.infinity,
//           height: double.infinity,
//           child: ListView(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 80,
//                 alignment: Alignment.center,
//                 child: const Text(
//                   "Welcome Back !",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 25, 85, 134),
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 250,
//                 width: 250,
//                 child: RiveAnimation.asset(
//                   "Animations/animatedBear.riv",
//                   fit: BoxFit.fitHeight,
//                   stateMachines: const ["Login Machine"],
//                   onInit: (artboard) {
//                     controller = StateMachineController.fromArtboard(
//                       artboard,
//                       "Login Machine",
//                     );
//                     if (controller == null) return;

//                     artboard.addController(controller!);
//                     isChecking = controller?.findInput("isChecking");
//                     numLook = controller?.findInput("numLook");
//                     isHandsUp = controller?.findInput("isHandsUp");
//                     // trigSuccess = controller?.findInput("trigSuccess");
//                     // trigFail = controller?.findInput("trigFail");
//                   },
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: TextFormField(
//                   focusNode: emailFocusNode,
//                   controller: _controllerEmail,
//                   decoration: const InputDecoration(
//                       labelText: 'Email',
//                       labelStyle:
//                           TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: TextField(
//                   focusNode: passwordFocusNode,
//                   obscureText: true,
//                   controller: _controllerPassword,
//                   decoration: const InputDecoration(
//                       labelText: 'Password',
//                       labelStyle:
//                           TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child:_errorMessage(),
//               ),
//               const SizedBox(height: 10,),
//               Container(
//                 height: 40,
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: _submitButton(),
//               ),
//               _loginOrRegisterButton()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
