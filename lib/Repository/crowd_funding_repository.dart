import 'dart:convert';
import 'dart:typed_data';

// import 'package:passkeys/types.dart';
import 'package:stellar_demo/Application/state.dart';
import 'package:stellar_demo/Constants/constants.dart';
import 'package:stellar_demo/Presentation/Components/toasts.dart';
import 'package:stellar_demo/Repository/project_model.dart';
import 'package:stellar_demo/Repository/soroban_server.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

enum FunctionType { initialize, deadline, state, target, token, balance, deposit, submit, withdraw, getProjectIds }

Map<FunctionType, String> functionToStringMap = {
  FunctionType.initialize: "initialize",
  FunctionType.deadline: "deadline",
  FunctionType.state: "state",
  FunctionType.target: "target",
  FunctionType.token: "token",
  FunctionType.balance: "balance",
  FunctionType.deposit: "contribute",
  FunctionType.submit: "submit",
  FunctionType.withdraw: "withdraw",
  FunctionType.getProjectIds: "get_projects"
};

class CrowdFundingRepository {
  static Future<String> fetchCrowdFunding() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Crowd Funding';
  }

  static createNewCrowdFundingCampaign(String name, String description, DateTime deadline) async {
    // if (AuthService.currentUser == null) return;
    List<XdrSCVal> vector = ([
      XdrSCVal.forSymbol("thisisCID"),
      XdrSCVal.forSymbol("CIDimagecid"),
      XdrSCVal.forSymbol("Dataannotation"),
      XdrSCVal.forSymbol("Exactlyit"),
      XdrSCVal.forSymbol("100"),
    ]);
    const target = 1000;
    List<XdrSCVal> args = ([
      XdrSCVal.forAccountAddress(PUBLIC),
      XdrSCVal.forU64(deadline.millisecondsSinceEpoch),
      XdrSCVal.forI128(XdrInt128Parts(XdrInt64(0), XdrUint64(target))),
      XdrSCVal.forVec(vector),
      XdrSCVal.forSymbol(name),
      XdrSCVal.forSymbol(description),
    ]);

    InvokeContractHostFunction hostFunction =
        InvokeContractHostFunction(SOROBAN_CONTRACT_ID, functionToStringMap[FunctionType.initialize]!, arguments: args);

    InvokeHostFunctionOperation operation = InvokeHostFuncOpBuilder(hostFunction).build();
    Account? account = await SorobanServerAPI.sorobanServer.getAccount(PUBLIC);
    if (account == null) {
      return;
    }
    Transaction transaction = new TransactionBuilder(account).addOperation(operation).build();
    var request = new SimulateTransactionRequest(transaction);
    SimulateTransactionResponse simulateResponse = await SorobanServerAPI.sorobanServer.simulateTransaction(request);
    transaction.sorobanTransactionData = simulateResponse.transactionData;
    transaction.addResourceFee(simulateResponse.minResourceFee!);
    var accountKeyPair = KeyPair.fromSecretSeed(PRIVATE);
    transaction.sign(accountKeyPair, Network.TESTNET);

    // Send the signed transaction
    try {
      final submitResponse = await SorobanServerAPI.sorobanServer.sendTransaction(transaction);
      showSuccessToast("Croudfund Campaign Created Succesfuly", "Transaction code: ${submitResponse.hash}");
    } catch (e) {
      print("Error submitting transaction: $e");
    }
  }

  static Future<SendTransactionResponse?> transact(HostFunction hostFunction) async {
    InvokeHostFunctionOperation operation = InvokeHostFuncOpBuilder(hostFunction).build();
    Account? account = await SorobanServerAPI.sorobanServer.getAccount(PUBLIC);
    if (account == null) {
      return null;
    }
    Transaction transaction = new TransactionBuilder(account).addOperation(operation).build();
    var request = new SimulateTransactionRequest(transaction);
    SimulateTransactionResponse simulateResponse = await SorobanServerAPI.sorobanServer.simulateTransaction(request);
    transaction.sorobanTransactionData = simulateResponse.transactionData;
    transaction.addResourceFee(simulateResponse.minResourceFee!);
    var accountKeyPair = KeyPair.fromSecretSeed(PRIVATE);
    transaction.sign(accountKeyPair, Network.TESTNET);

    // Send the signed transaction
    try {
      return await SorobanServerAPI.sorobanServer.sendTransaction(transaction);
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Projectt?>> getProjects() async {
    InvokeContractHostFunction hostFunction =
        InvokeContractHostFunction(SOROBAN_CONTRACT_ID, functionToStringMap[FunctionType.getProjectIds]!);
    var submitResponse = await transact(hostFunction);
    GetTransactionResponse txResponse = await SorobanServerAPI.sorobanServer.getTransaction(submitResponse!.hash!);
    while (txResponse.status == GetTransactionResponse.STATUS_NOT_FOUND) {
      await Future.delayed(const Duration(seconds: 3));
      txResponse = await SorobanServerAPI.sorobanServer.getTransaction(submitResponse!.hash!);
    }
    XdrSCVal val = txResponse.getResultValue()!;
    List<Projectt> projects = [];
    val.vec!.forEach((e) {
      projects.add(Projectt.fromMap(e.map!));
    });
    return projects;
  }

  static Future<void> submit(String label, int projId, String data) async {
    InvokeContractHostFunction hostFunction =
        InvokeContractHostFunction(SOROBAN_CONTRACT_ID, functionToStringMap[FunctionType.getProjectIds]!);

    List<XdrSCVal> args = ([
      XdrSCVal.forAccountAddress(PUBLIC),
      XdrSCVal.forSymbol(data),
      XdrSCVal.forU32(0),
      XdrSCVal.forU32(0),
      XdrSCVal.forU32(0),
      XdrSCVal.forU32(0),
      XdrSCVal.forSymbol(label),
      XdrSCVal.forU32(projId),
    ]);

    InvokeHostFunctionOperation operation = InvokeHostFuncOpBuilder(hostFunction).build();
    Account? account = await SorobanServerAPI.sorobanServer.getAccount(PUBLIC);
    if (account == null) {
      return;
    }
    Transaction transaction = new TransactionBuilder(account).addOperation(operation).build();
    var request = new SimulateTransactionRequest(transaction);
    SimulateTransactionResponse simulateResponse = await SorobanServerAPI.sorobanServer.simulateTransaction(request);
    transaction.sorobanTransactionData = simulateResponse.transactionData;
    transaction.addResourceFee(simulateResponse.minResourceFee!);
    var accountKeyPair = KeyPair.fromSecretSeed(PRIVATE);
    transaction.sign(accountKeyPair, Network.TESTNET);

    // Send the signed transaction
    try {
      final submitResponse = await SorobanServerAPI.sorobanServer.sendTransaction(transaction);
      showSuccessToast("Label submitted successfully", "Transaction code: ${submitResponse.hash}");
    } catch (e) {
      print("Error submitting transaction: $e");
    }
  }
}
