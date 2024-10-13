// import 'package:passkeys/authenticator.dart';
// import 'package:passkeys/types.dart';
// import 'package:stellar_demo/Repository/rlp_service.dart';
// import 'package:stellar_demo/Repository/soroban_server.dart';

// class AuthService {
//   static PasskeyAuthenticator authenticator = PasskeyAuthenticator();
//   static LocalUser? currentUser;

//   static Future<void> loginWithPasskey({required String email}) async {
//     final rps1 = LocalRelyingPartyServer.startPasskeyLogin(name: email);
//     final authenticatorRes = await authenticator.authenticate(rps1);
//     currentUser = LocalRelyingPartyServer.finishPasskeyLogin(response: authenticatorRes);
//   }

//   static Future<void> loginWithPasskeyConditionalUI() async {
//     final rps1 = LocalRelyingPartyServer.startPasskeyLoginConditionalU();
//     final authenticatorRes = await authenticator.authenticate(rps1);
//     currentUser = LocalRelyingPartyServer.finishPasskeyLoginConditionalUI(response: authenticatorRes);
//   }

//   static Future<void> signupWithPasskey({required String email}) async {
//     final rps1 = LocalRelyingPartyServer.startPasskeyRegister(name: email);
//     final authenticatorRes = await authenticator.register(rps1);
//     currentUser = LocalRelyingPartyServer.finishPasskeyRegister(response: authenticatorRes);
//     await SorobanServerAPI.fundTestAccount(currentUser!.credentialID!);
//   }
// }
