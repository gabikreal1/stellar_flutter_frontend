import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' as stellar;
import 'dart:core';

class Projectt {
  int id;
  String name;
  String description;
  String recipient; // Changed to String for easier parsing
  int started;
  int deadline;
  int targetAmount;
  int currentAmount;
  Map<String, DataPoint> dataPoints;
  Map<String, int> contributorsContributionMap; // Changed key to String
  Map<String, int> annotatorsEarningMap; // Changed key to String
  State state;

  Projectt({
    required this.id,
    required this.name,
    required this.description,
    required this.recipient,
    required this.started,
    required this.deadline,
    required this.targetAmount,
    required this.currentAmount,
    required this.dataPoints,
    required this.contributorsContributionMap,
    required this.annotatorsEarningMap,
    required this.state,
  });

  factory Projectt.fromMap(List<stellar.XdrSCMapEntry> entries) {
    Map<String, stellar.XdrSCVal> map = {for (var entry in entries) entry.key.sym!: entry.val};
    return Projectt(
      id: _parseU32(map['id']!),
      name: _parseString(map['name']!),
      description: _parseString(map['description']!),
      recipient: _parseAccount(map['recipient']!),
      started: _parseU64(map['started']!),
      deadline: _parseU64(map['deadline']!),
      targetAmount: _parseI128(map['target_amount']!),
      currentAmount: _parseI128(map['current_amount']!),
      dataPoints: _parseDataPoints(map['data_points']!),
      contributorsContributionMap: _parseAddressToI128Map(map['contributors_contribution_map']!),
      annotatorsEarningMap: _parseAddressToI128Map(map['annotators_earning_map']!),
      state: State.values[_parseU32(map['state']!)],
    );
  }

  static int _parseU32(stellar.XdrSCVal val) => val.u32!.uint32;

  static String _parseString(stellar.XdrSCVal val) => val.sym!;

  static String _parseAccount(stellar.XdrSCVal val) => val.address!.accountId?.accountID.toString() ?? "";

  static int _parseU64(stellar.XdrSCVal val) => val.u64!.uint64;

  static int _parseI128(stellar.XdrSCVal val) {
    return val.i128!.lo.uint64;
  }

  static Map<String, DataPoint> _parseDataPoints(stellar.XdrSCVal val) {
    Map<String, stellar.XdrSCVal> scValMap = Map.fromEntries(val.map!.map((e) => MapEntry(e.key.sym!, e.val)));
    return scValMap.map((key, value) => MapEntry(key, DataPoint.fromSCVal(value)));
  }

  static Map<String, int> _parseAddressToI128Map(stellar.XdrSCVal val) {
    Map<String, stellar.XdrSCVal> scValMap = Map.fromEntries(val.map!.map((e) => MapEntry(e.key.sym!, e.val)));
    return scValMap.map((key, value) => MapEntry(key, _parseI128(value)));
  }
}

class DataPoint {
  // This is a placeholder. Adjust according to your actual DataPoint structure
  dynamic value;

  DataPoint({required this.value});

  factory DataPoint.fromSCVal(stellar.XdrSCVal val) {
    // Implement parsing logic based on your DataPoint structure
    return DataPoint(value: val.str);
  }
}

enum State {
  Active,
  Completed,
  Failed,
  // Add other states as needed
}
