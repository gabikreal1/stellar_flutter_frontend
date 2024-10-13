import 'package:stellar_demo/Constants/constants.dart';
import 'package:stellar_demo/Repository/auth_service.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class SorobanServerAPI {
  static SorobanServer sorobanServer = SorobanServer(SOROBAN_SERVER_ADDRESS);

  static Future<Account?> getAccountDetails(String passkeyCredentialId) async {
    return await sorobanServer.getAccount(deriveStellarPublicKeyFromPasskey(passkeyCredentialId));
  }

  static Future<void> fundTestAccount(String passkeyCredentialId) async {
    await FriendBot.fundTestAccount(deriveStellarPublicKeyFromPasskey(passkeyCredentialId));
  }
}

String deriveStellarPublicKeyFromPasskey(String passkeyCredentialId) {
  // Hash the credential ID to get a 32-byte value
  var hash = sha256.convert(Uint8List.fromList(passkeyCredentialId.codeUnits));

  // Use the first 32 bytes of the hash as the seed for the Stellar key pair
  var seed = hash.bytes.sublist(0, 32);

  // Convert the seed to a hex string
  var seedHex = hex.encode(seed);

  // Generate a Stellar key pair from the seed
  var keyPair = KeyPair.fromSecretSeed(seedHex);

  // Return the public key
  return keyPair.accountId;
}
