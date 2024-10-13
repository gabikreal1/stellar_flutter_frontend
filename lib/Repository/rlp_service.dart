// import 'dart:collection';
// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';

// import 'package:passkeys/types.dart';
// import 'package:stellar_demo/Constants/constants.dart';
// import 'package:uuid/v4.dart';
// import 'package:cbor/cbor.dart';

// class LocalUser {
//   LocalUser({required this.name, required this.id, this.credentialID, this.signature});

//   final String name;
//   final String id;
//   String? credentialID;
//   String? signature;
// }

// /// This is a local version of a relying party server.
// ///
// /// Note:
// /// The concept of a local relying party server works just in examples. It does not work in practice.
// /// Usually a relying party server is party of your backend.
// class LocalRelyingPartyServer {
//   static Map<String, LocalUser> _users = HashMap();
//   static Map<String, LocalUser> _inFlightChallenges = HashMap();
//   static Random _random = Random.secure();
//   static LocalUser? _currentUser;

//   static RegisterRequestType startPasskeyRegister({required String name}) {
//     if (_users.containsKey(name)) {
//       throw Exception('User $name already exists. Please log in instead');
//     }

//     final userID = const UuidV4().generate();
//     final newUser = LocalUser(id: userID, name: name);
//     final challenge = generateChallenge();
//     _inFlightChallenges[challenge] = newUser;

//     final rp = RelyingPartyType(name: RP_NAME, id: RP_ID);
//     final user = UserType(
//       displayName: name,
//       name: name,
//       id: base64Url.encode(userID.codeUnits),
//     );
//     final authenticatorSelection = AuthenticatorSelectionType(
//       requireResidentKey: false,
//       residentKey: 'required',
//       userVerification: 'preferred',
//     );

//     return RegisterRequestType(
//       challenge: challenge,
//       relyingParty: rp,
//       user: user,
//       authSelectionType: authenticatorSelection,
//       pubKeyCredParams: [
//         PubKeyCredParamType(type: 'public-key', alg: -257),
//       ],
//       excludeCredentials: [],
//     );
//   }

//   /// Note: we don't implement a full relying party server here.
//   /// To safe effort we don't verify the response from the authenticator.
//   static LocalUser finishPasskeyRegister({required RegisterResponseType response}) {
//     final raw = '${response.clientDataJSON}=';
//     final json = jsonDecode(String.fromCharCodes(base64.decode(raw)));

// // Extract the authData from the decoded object

//     final challenge = json['challenge'];
//     final user = _inFlightChallenges[challenge];
//     if (user == null) {
//       throw Exception('invalid state: user does not exist');
//     }

//     user.credentialID = response.id;
//     _users[user.name] = user;
//     _currentUser = user;
//     return user;
//   }

//   static AuthenticateRequestType startPasskeyLogin({required String name}) {
//     if (!_users.containsKey(name)) {
//       throw Exception('User $name does not exist. Please register first');
//     }

//     final challenge = generateChallenge();
//     _inFlightChallenges[challenge] = _users[name]!;

//     return AuthenticateRequestType(
//       relyingPartyId: RP_ID,
//       challenge: challenge,
//       mediation: MediationType.Optional,
//       preferImmediatelyAvailableCredentials: false,
//     );
//   }

//   static LocalUser finishPasskeyLogin({required AuthenticateResponseType response}) {
//     final raw = '${response.clientDataJSON}=';
//     final json = jsonDecode(String.fromCharCodes(base64.decode(raw)));
//     final challenge = json['challenge'];
//     final user = _inFlightChallenges[challenge];
//     if (user == null) {
//       throw Exception('invalid state: user does not exist');
//     }

//     user.signature = response.signature;
//     _currentUser = user;
//     return user;
//   }

//   static AuthenticateRequestType startPasskeyLoginConditionalU() {
//     final challenge = generateChallenge();

//     return AuthenticateRequestType(
//       relyingPartyId: RP_ID,
//       challenge: challenge,
//       mediation: MediationType.Conditional,
//       preferImmediatelyAvailableCredentials: false,
//     );
//   }

//   /// Note: we don't implement a full relying party server here.
//   /// To safe effort we don't verify the response from the authenticator.
//   static LocalUser finishPasskeyLoginConditionalUI({required AuthenticateResponseType response}) {
//     LocalUser? existingUser;
//     for (final user in _users.values) {
//       if (user.credentialID != null && user.credentialID == response.id) {
//         existingUser = user;
//       }
//     }

//     if (existingUser == null) {
//       throw Exception('User does not exist');
//     }
//     existingUser.signature = response.signature;
//     _currentUser = existingUser;
//     return existingUser;
//   }

//   static String generateChallenge() {
//     const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
//     var rawChallenge = '';
//     for (var i = 0; i < 32; i++) {
//       rawChallenge += chars[_random.nextInt(chars.length)];
//     }

//     final a = base64Url.encode(rawChallenge.codeUnits);

//     return a.substring(0, a.length - 1);
//   }
// }
