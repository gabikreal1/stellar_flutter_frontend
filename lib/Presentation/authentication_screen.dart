// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:passkeys/exceptions.dart';
// import 'package:stellar_demo/Presentation/Components/auth_textfield.dart';
// import 'package:stellar_demo/Presentation/Components/main_button.dart';

// import '../Repository/auth_service.dart';
// import 'router.dart';

// class AuthenticationScreen extends StatefulWidget {
//   const AuthenticationScreen({super.key});

//   @override
//   State<AuthenticationScreen> createState() => _AuthenticationScreenState();
// }

// class _AuthenticationScreenState extends State<AuthenticationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // As soon as the view has been loaded prepare the autocompleted passkey sign in.
//       AuthService.loginWithPasskeyConditionalUI().then((value) => context.go(Routes.main)).onError(
//         (error, stackTrace) {
//           if (error is PasskeyAuthCancelledException) {
//             debugPrint('user cancelled authentication. This is not a problem. It can just be started again.');
//             return;
//           }

//           debugPrint('error: $error');
//         },
//       );
//     });
//   }

//   final keyNameController = TextEditingController();
//   void signIn() async {
//     try {
//       final email = keyNameController.value.text;
//       await AuthService.loginWithPasskey(email: email);
//       context.go(Routes.main);
//     } catch (e) {
//       if (e is PasskeyAuthCancelledException) {
//         debugPrint('user cancelled authentication. This is not a problem. It can just be started again.');
//         return;
//       }
//     }
//   }

//   void signUp() async {
//     final email = keyNameController.value.text;
//     try {
//       await AuthService.signupWithPasskey(email: email);
//       context.go(Routes.main);
//     } catch (e) {
//       debugPrint('error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AuthTextField(controller: keyNameController, hintText: "Key Name (e.g Stellar)", obscureText: false),
//           MainButton(
//             text: "Sign In",
//             onTap: signIn,
//             padding: 15.0,
//             inProgress: false,
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           ElevatedButton(onPressed: signUp, child: Text("Sign Up")),
//         ],
//       ),
//     ));
//   }
// }
