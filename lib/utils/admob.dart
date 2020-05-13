import 'package:firebase_admob/firebase_admob.dart';

class Admob {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: false,
    childDirected: true,
    keywords: <String>['Game', 'Color', 'Puzzle Game'],
  );

  static const String appID = "ca-app-pub-7224518266029611~5643305504";

  static const String bannerID = "ca-app-pub-7224518266029611/4745990954";

  static const String middleID = "ca-app-pub-7224518266029611/8077897150";

  static const String continuationID = "ca-app-pub-7224518266029611/3706928376";
}
